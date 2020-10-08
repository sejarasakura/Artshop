using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls;
using WebApplication1.model;
using WebApplication1.Class;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Data.Entity.Migrations;

namespace WebApplication1.pages
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        public string post = "0";
        public User user = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetPost();
            if (post.Equals("1"))
            {
                somthing_wrong("alert-success", "<h1><strong>Mail sended !! Please check your email and procide to next step !!</strong></h1>");
            }
        }
        protected void submitButton_Click(object sender, EventArgs e)
        {
            User u = new User();
            bool sended = false;
            string newPassword;
            model.ChangePassword changePassword = new model.ChangePassword();

            using (WebApplication1.model.ArtGalleryV2Entities db = new WebApplication1.model.ArtGalleryV2Entities())
            {
                u.user_email = EmailText.Text;
                bool found = false;
                try
                {
                    User[] users = db.Users.ToArray();
                    foreach (User temp in users)
                    {
                        if (temp.user_email.Replace(" ", "").Equals(u.user_email.Replace(" ", "")))
                        {
                            u = temp;
                            found = true;
                            break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    somthing_wrong("alert-danger", "<strong>Something worong with eception !!</strong> " + ex.Message + "!!");
                    return;
                }
                if (!found)
                {
                    somthing_wrong("alert-danger", "<strong>The following mail not found !!</strong> Please please try agian or <a href=\"Register.aspx\">register now</a> !!");
                    return;
                }

                // get new primary key
                List<model.ChangePassword> arts = db.ChangePasswords.ToList();
                int count = arts.Count;
                if (arts.Count > 0)
                {
                    model.ChangePassword c = db.ChangePasswords.Find(arts.Count - 1);
                    changePassword.Id = (c.Id + 1);
                }
                newPassword = Membership.GeneratePassword(20, 0);
                newPassword = Regex.Replace(newPassword, @"[^a-zA-Z0-9]", m => "9");
            }
            var m_content = "";
            m_content += "Hi, Dear user " + u.username + ", <br /><br />";
            m_content += "You has request to changing password in our website <br /><br />";
            m_content += "If you did no request any change, please contact the site admin in our web site <br /><br />";
            m_content += "Please click the link to <a href=\"";
            m_content += "https://" + HttpContext.Current.Request.Url.Authority + "/pages/ChangePassword.aspx?post=" + newPassword;
            m_content += "\">continue change password. </a> <br /><br />";

            try
            {
                sended = Class.SendMail.send_mail(
                   "Change password",
                   "This notice confirms that your password request to change on ArtWork Sales. !!",
                   m_content,
                   u.user_email
               );
                changePassword.temp_password = newPassword;
                changePassword.user_id = u.user_id;

                using (WebApplication1.model.ArtGalleryV2Entities db = new WebApplication1.model.ArtGalleryV2Entities())
                {
                    db.ChangePasswords.Add(changePassword);
                    if (db.SaveChanges() > 0)
                    {
                        Response.Redirect("ChangePassword.aspx?post=1");
                    }
                    else
                    {
                        Response.Redirect("ChangePassword.aspx?post=0");
                    }
                }
            }
            catch (Exception ex2)
            {
                post = "0";
                Exception ex3 = ex2;
                string errorMessage = string.Empty;
                while (ex3 != null)
                {
                    errorMessage += ex3.ToString();
                    ex3 = ex3.InnerException;
                }
                somthing_wrong("alert-danger", "<strong>Something worong email not send !!!!</strong> with error " + errorMessage);
                return;
            }

        }
        protected void submitButton_Click2(object sender, EventArgs e)
        {
            model.ChangePassword result = new model.ChangePassword();
            GetPost();
            using (WebApplication1.model.ArtGalleryV2Entities db = new WebApplication1.model.ArtGalleryV2Entities())
            {
                var data = db.ChangePasswords.SqlQuery(
                    "SELECT * FROM [ChangePassword] WHERE temp_password = @temp_password",
                    new SqlParameter("@temp_password", post));
                if (data == null)
                {
                    somthing_wrong("alert-danger", "<b>Your not able to procide to the next step !!</b> the link have been expired or used");
                    return;
                }
                try
                {
                    result = data.ToArray()[0];
                }
                catch
                {
                    somthing_wrong("alert-danger", "<b>Your not able to procide to the next step !!</b> the link have been expired or used");
                    return;
                }
                // check user password enter is match
                if (this.PasswordText1.Text != PasswordText2.Text)
                {
                    somthing_wrong("alert-danger", "<b>Your entered password not match to each other !!</b>");
                    return;
                }
                try
                {
                    // change user password
                    User temp = db.Users.Find(result.user_id);
                    temp.password = PasswordText1.Text;
                    db.Users.AddOrUpdate(temp);
                    // delete Change password if chage user password done
                    db.ChangePasswords.Remove(result);
                    // Save change
                    if (db.SaveChanges() > 0)
                    {
                        ChangePass.Visible = false;
                        somthing_wrong("alert-success", "<b>Your password is updated to enterd passwod !!</b><a href=\"Login.aspx\">Login Now</a>");
                    }
                    else
                    {
                        somthing_wrong("alert-danger", "<b>Your password updated fail !!</b>");
                    }
                }
                catch (Exception ex)
                {
                    somthing_wrong("alert-danger", "<b>Your password updated fail !!</b>" + ex.Message);
                }
            }
        }
        public void GetPost()
        {
            if (Request.QueryString["post"] == null)
            {
                post = "0";
            }
            else
            {
                post = Request.QueryString["post"].ToString();
            }
        }
        public void somthing_wrong(string css_class, string error)
        {
            preview.InnerHtml =
              "<div class=\"alert " + css_class + " alert-dismissible\">" +
                "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                error +
              "</div>";
        }

        public void GetUser()
        {
            model.ChangePassword result = new model.ChangePassword();
            user = WebApplication1.master.Site1.GetLogin(Response);
            if(user != null)
            {
                EmailText.Text = user.user_email;
            }
            GetPost();
            if (post.Length == 20)
            {
                using (WebApplication1.model.ArtGalleryV2Entities db = new WebApplication1.model.ArtGalleryV2Entities())
                {
                    var data = db.ChangePasswords.SqlQuery(
                        "SELECT * FROM [ChangePassword] WHERE temp_password = @temp_password",
                        new SqlParameter("@temp_password", post));
                    if (data == null)
                    {
                        somthing_wrong("alert-danger", "<b>Your not able to procide to the next step !!</b>");
                        return;
                    }
                    try
                    {
                        result = data.ToArray()[0];
                        user = db.Users.Find(result.user_id);
                    }
                    catch
                    {
                        user = null;
                    }
                }
            }
        }
    }
}