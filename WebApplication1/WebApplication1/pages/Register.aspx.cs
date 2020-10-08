using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1;
using WebApplication1.model;
using WebApplication1.Class;
using WebApplication1.master;
using System.IO;
using System.Data.Entity.Migrations;

namespace WebApplication1.pages
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void submitButton_Click(object sender, EventArgs e)
        {
            User data = new User();
            data.user_email = this.EmailText.Text;
            data.username = this.UsernameText.Text;
            data.last_name = this.LNameText.Text;
            data.first_name = this.FNameText.Text;
            data.user_role = ((char)this.read_checkbox()).ToString();
            data.gender = ((char)this.read_radio()).ToString();
            data.phone_num = this.PhoneNumber.Text;
            if (this.PasswordText.Text == this.PasswordText2.Text)
                data.password = this.PasswordText.Text;
            if (FileUpload.HasFile)
                data.picture = FileUpload.FileBytes;
            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                List<User> user = db.Users.ToList<User>();
                int count = user.Count;
                if (count > 0)
                {
                    User c = db.Users.Find(user.Last().user_id);
                    data.user_id = (c.user_id + 1);
                }
                else
                {
                    data.user_id = (0);
                }
                try
                {
                    db.Users.Add(data);
                    db.SaveChanges();
                    User x = db.Users.Find(count);
                    preview.InnerHtml =
                      "<div class=\"alert alert-success alert-dismissible\">" +
                        "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                        "<strong>Registeration Sucessful!</strong> " + data.username + "<i>( " + data.user_email + " )</i>" + " has done registration !!" +
                      "</div>";
                }
                catch (Exception x)
                {
                    preview.InnerHtml =
                      "<div class=\"alert alert-danger alert-dismissible\">" +
                        "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                        "<strong>Registeration Fail!</strong> You register not successful please try agian. " + x.Message +
                      "</div>";
                }
            }

        }

        public string getImage()
        {
            string data = CookiesManage.GetFromCookie(Site1.LOGIN_ID_PHASE, "user_id");
            if (data != null)
            {
                int id = Int16.Parse(data);
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    try
                    {
                        return "data:Image/png;64base," +
                            Convert.ToBase64String(db.Users.Find(id).picture);
                    }
                    catch { }
                }
            }
            return "~/media/unknow_user.png";
        }

        private Gender read_radio()
        {
            if (Radio1.Checked)
            {
                return Gender.Female;
            }
            else if (Radio2.Checked)
            {
                return Gender.Male;
            }
            else
            {
                return Gender.Unknow;
            }
        }
        private UserRole read_checkbox()
        {
            if (this.CheckArtist.Checked)
            {
                return UserRole.Artist;
            }
            else if (this.CheckCustomer.Checked)
            {
                return UserRole.Customer;
            }
            else if (this.CheckBoth.Checked)
            {
                return UserRole.Both;
            }
            else
            {
                return UserRole.Customer;
            }
        }
    }
}