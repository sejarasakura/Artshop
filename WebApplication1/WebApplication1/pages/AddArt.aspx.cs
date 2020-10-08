using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Class;
using WebApplication1.master;
using WebApplication1.model;

namespace WebApplication1.pages
{
    public partial class AddArt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void submitButton_Click(object sender, EventArgs e)
        {
            Art art = new Art();
            User user = Site1.GetLogin(Response);
            if(user == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!user.user_role.Equals("A"))
            {
                Response.Redirect("Home.aspx");
            }
            art.artist_id = user.user_id;
            art.name = this.TitleText.Text;
            art.quantity = Int32.Parse(this.Quantity.Text);
            art.price = (decimal?)float.Parse(this.Price.Text);
            art.date_done = DateTime.ParseExact(this.DateCreation.Text, "yyyy-MM-dd", null);
            preview.InnerHtml = DateCreation.Text;
            art.description = this.Discription.Text;
            if (this.FileUpload.HasFile)
            {
                art.image = FileUpload.FileBytes;
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    List<Art> arts = db.Arts.ToList();
                    int count = arts.Count;
                    if (arts.Count > 0)
                    {
                        Art c = db.Arts.Find(arts.Count - 1);
                        art.art_id = (c.art_id + 1);
                    }
                    try
                    {
                        db.Arts.Add(art);
                        db.SaveChanges();
                        preview.InnerHtml +=
                          "<div class=\"alert alert-success alert-dismissible\">" +
                            "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                            "<strong>Posted New Product !!!</strong>" +
                          "</div>";
                    }
                    catch (Exception x)
                    {
                        preview.InnerHtml +=
                          "<div class=\"alert alert-danger alert-dismissible\">" +
                            "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                            "<strong>Registeration Fail!</strong> You register not sucessful please try agian. " + x.Message +
                          "</div>";
                    }
                }
            }
            else
            {
                preview.InnerHtml +=
                  "<div class=\"alert alert-danger alert-dismissible\">" +
                    "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                    "<strong>Registeration Fail!</strong> You register not sucessful please try agian. " +
                  "</div>";
            }

        }


        public string getImage(int id)
    {
            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                try
                {
                    return ImgConvert.convert_image(db.Arts.Find(id).image);
                }
                catch { }
            }
            return "~/media/unknow_user.png";
        }

    }
}