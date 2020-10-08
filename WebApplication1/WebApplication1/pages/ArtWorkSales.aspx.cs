using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.model;

namespace WebApplication1.pages
{
    public partial class ArtWorkSales : System.Web.UI.Page
    {
        public WebApplication1.model.User user;
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadUser();
            if (user != null)
                SqlDataSource1.SelectParameters["artist_id"].DefaultValue = user.user_id + "";
        }

        protected void LoadUser()
        {
            if (user == null)
                user = WebApplication1.master.Site1.GetLogin(Response);

            if (user == null)
                Response.Redirect("Login.aspx");
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //// check row type
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //    // if row type is DataRow, add ProductSales value to TotalSales
            //    TotalSales += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ProductSales"));
            //else if (e.Row.RowType == DataControlRowType.Footer)
            //    // If row type is footer, show calculated total value
            //    // Since this example uses sales in dollars, I formatted output as currency
            //    e.Row.Cells[1].Text = String.Format("{0:c}", TotalSales);
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete Row")
            {
                int crow;
                crow = Convert.ToInt32(e.CommandArgument.ToString());
                string rollno = GridView1.Rows[crow].Cells[0].Text;
                deleterowdata(rollno);
            }
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GridView1.DataBind();
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int crow;
            crow = e.RowIndex;
            update_role(crow);
            GridView1.EditIndex = -1;
            GridView1.DataBind();
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
        }
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.DataBind();
        }
        private void update_role(int rollno)
        {
            string textID = GridView1.Rows[rollno].Cells[0].Text;
            string textQun = ((TextBox)GridView1.Rows[rollno].FindControl("TextBoxQuantity")).Text;
            string textDes = ((TextBox)GridView1.Rows[rollno].FindControl("TextBoxDes")).Text;
            string textName = ((TextBox)GridView1.Rows[rollno].FindControl("TextBoxName")).Text;
            string textPrice = ((TextBox)GridView1.Rows[rollno].FindControl("TextBoxPrice")).Text;
            FileUpload fileUpload = GridView1.Rows[rollno].FindControl("FileUpload1") as FileUpload;
            try
            {
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    Art c = db.Arts.Find(int.Parse(textID));
                    c.quantity = int.Parse(textQun);
                    c.description = textDes;
                    c.name = textName;
                    c.price = decimal.Parse(textPrice);
                    if(fileUpload.HasFile)
                        c.image = fileUpload.FileBytes;

                    db.Arts.AddOrUpdate(c);
                    db.SaveChanges();
                    preview.InnerHtml =
                      "<div class=\"alert alert-success alert-dismissible\">" +
                        "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                        "<strong>Updated Sucessful!</strong> done updating !!" +
                      "</div>";
                }
            }
            catch (Exception e)
            {
                preview.InnerHtml =
                  "<div class=\"alert alert-danger alert-dismissible\">" +
                    "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                    "<strong>Updating Fail!</strong> please try agian !!" + e.Message +
                  "</div>";
            }
        }
        private void deleterowdata(String rollno)
        {
            try
            {
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    Art c = db.Arts.Find(int.Parse(rollno));
                    db.Arts.Remove(c);
                    db.SaveChanges();
                    GridView1.DataBind();
                    preview.InnerHtml =
                      "<div class=\"alert alert-success alert-dismissible\">" +
                        "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                        "<strong>Deleted Sucessful!</strong> you have remove item  : [ " + db.Arts.Find(c.art_id).name + "] !!" +
                      "</div>";
                }
            }
            catch
            {
                preview.InnerHtml =
                  "<div class=\"alert alert-danger alert-dismissible\">" +
                    "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                    "<strong>Deleted Fail!</strong> please try agian !!" +
                  "</div>";
            }
        }
    }
}