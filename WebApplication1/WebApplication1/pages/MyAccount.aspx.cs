using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Class;
using WebApplication1.master;
using WebApplication1.model;

namespace WebApplication1.pages
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.UsernameText.Text == "")
            {
                start_page();
            }
        }

        private void start_page()
        {

            User data = Site1.GetLogin(Response);
            if (data != null)
            {
                this.UsernameText.Text = data.username;
                this.EmailText.Text = data.user_email;
                this.FNameText.Text = data.first_name;
                this.LNameText.Text = data.last_name;
                this.write_checkbox((UserRole)Char.Parse(data.user_role));
                this.write_radio((Gender)Char.Parse(data.gender));
                this.PhoneNumber.Text = data.phone_num;
            }
            else
            {
                preview.InnerHtml =
                  "<div class=\"alert alert-danger alert-dismissible\">" +
                    "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                    "<strong>Account Not Found ! ! !</strong> You account not found in our database. Please Login Before Edit" +
                  "</div>";
                return;
            }
        }

        public void submitButton_Click(object sender, EventArgs e)
        {
            User data = Site1.GetLogin(Response);
            if(data == null)
            {
                preview.InnerHtml =
                  "<div class=\"alert alert-danger alert-dismissible\">" +
                    "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                    "<strong>Account Not Found ! ! !</strong> You account not found in our database. Please Login Before Edit" +
                  "</div>";
                return;
            }
            data.last_name = this.LNameText.Text;
            data.first_name = this.FNameText.Text;
            data.user_role = ((char)this.read_checkbox()).ToString();
            data.gender = ((char)this.read_radio()).ToString();
            data.phone_num = this.PhoneNumber.Text;
            if (FileUpload.HasFile)
                data.picture = FileUpload.FileBytes;
            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                try
                {
                    db.Users.Attach(data);
                    db.Entry(data).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    User x = db.Users.Find(data.user_id);
                    preview.InnerHtml =
                      "<div class=\"alert alert-success alert-dismissible\">" +
                        "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                        "<strong>" +"Update Sucessful!</strong> your " + x.username + "<i>( " + x.user_email + " )</i>" + " account information is updated !!" +
                      "</div>";
                }
                catch (Exception x)
                {
                    preview.InnerHtml =
                      "<div class=\"alert alert-danger alert-dismissible\">" +
                        "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                        "<strong>Update Fail!</strong> You update not sucessful please try agian. " + x.Message +
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
        private void write_radio(Gender gender)
        {
            if (Gender.Female==gender)
            {
                Radio1.Checked = true;
                Radio2.Checked = false;
            }
            else if (Gender.Male == gender)
            {
                Radio2.Checked = true;
                Radio1.Checked = false;
            }
            else
            {
                Radio2.Checked = false;
                Radio1.Checked = false;
            }
        }
        private void write_checkbox(UserRole userRole)
        {
            switch (userRole)
            {
                case UserRole.Artist:
                    this.CheckCustomer.Checked = false;
                    this.CheckArtist.Checked = true;
                    this.CheckBoth.Checked = false;
                    break;
                case UserRole.Both:
                    this.CheckCustomer.Checked = false;
                    this.CheckArtist.Checked = false;
                    this.CheckBoth.Checked = true;
                    break;
                default:
                    this.CheckCustomer.Checked = true;
                    this.CheckArtist.Checked = false;
                    this.CheckBoth.Checked = false;
                    break;
            }
        }
    }
}