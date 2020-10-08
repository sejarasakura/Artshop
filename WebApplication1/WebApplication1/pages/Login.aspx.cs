using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.master;
using WebApplication1.Class;

namespace WebApplication1.pages
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        public static WebApplication1.model.User user = null;
        public static string error_m = null;
        public Boolean submit = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            submit = false;
        }
        
        protected void loginButton_Click(object sender, EventArgs e)
        {
            submit = false;
        }

        protected void logoutButton_Click(object sender, EventArgs e)
        {
            submit = false;
            logout();
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            preview.InnerHtml += PasswordText.Text + "," + EmailText.Text + "<br />";
            error_m = "Not Found Your Account";
            Boolean is_login = false;
            using (WebApplication1.model.ArtGalleryV2Entities db = new WebApplication1.model.ArtGalleryV2Entities())
            {
                List<WebApplication1.model.User> all_user = db.Users.ToList<WebApplication1.model.User>();
                foreach (WebApplication1.model.User temp_user in all_user)
                {
                    string psw = PasswordText.Text;
                    preview.InnerHtml += temp_user.username + "(" + temp_user.user_email.Equals(EmailText.Text) + ")" + "," + temp_user.user_email +"("+ temp_user.username.Equals(EmailText.Text)+")" + "," + temp_user.password + "(" + temp_user.password.Equals(psw) + ")" + "<br />";
                    if (temp_user.user_email.Replace(" ", "").Equals(EmailText.Text) || temp_user.username.Replace(" ", "").Equals(EmailText.Text))
                    {
                        // email correct password correct 
                        if (temp_user.password.Replace(" ", "").Equals(psw))
                        {
                            is_login = true;
                            error_m = null;
                            user = new WebApplication1.model.User();
                            user.user_email = temp_user.user_email;
                            user.username = temp_user.username;
                            user.user_id = temp_user.user_id;
                            user.user_role = temp_user.user_role;
                            user.picture = temp_user.picture;
                            login(temp_user.user_id + "");
                            submit = true;
                            return;
                        }
                        // email correct password wrong
                        else
                        {
                            error_m = "Entered password is incorrect";
                            user = null;
                            break;
                        }
                    }
                    else
                    {
                        // email wrong
                        error_m = "Entered email or username is error";
                        user = null;
                    }
                }
                if (!is_login)
                {
                    preview.InnerHtml +=
                      "<div class=\"alert alert-danger alert-dismissible\">" +
                        "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                        "<strong>Login Fail!</strong> " + error_m + "!!" +
                      "</div>";
                    user = null;
                }
            }
            submit = false;
        }

        internal static void clear()
        {
            user = null;
            error_m = null;
        }

        public void logout()
        {
            // remove cookies
            CookiesManage.RemoveCookie(Site1.LOGIN_ID_PHASE, "user_id");
            user = null;
            error_m = null;
            submit = false;
        }

        private void login(string id)
        {
            // set dictionary
            Dictionary<string, string> data = new Dictionary<string, string>();
            data.Add("user_id", id);
            // set date 
            DateTime now = DateTime.UtcNow;
            // set cookies
            CookiesManage.StoreInCookie(Site1.LOGIN_ID_PHASE, data, now.AddMinutes(30.0), false);
            submit = false;
        }

    }
}