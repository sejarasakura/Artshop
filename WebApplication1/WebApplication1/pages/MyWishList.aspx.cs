using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Migrations;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.model;

namespace WebApplication1.pages
{
    public partial class MyWishList : System.Web.UI.Page
    {
        private List<OrderDetail> order_de = new List<OrderDetail>();
        private List<Cart> cart_list = new List<Cart>();
        protected void Page_Load(object sender, EventArgs e)
        {
            WebApplication1.model.User user = WebApplication1.master.Site1.GetLogin(Response);
            if (user != null)
            {
                SqlDataSource1.SelectParameters["user_id"].DefaultValue = user.user_id + "";
            }
            else
            {
                preview.InnerHtml =
                  "<div class=\"alert alert-danger alert-dismissible\">" +
                    "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                    "<strong>Your Account Not Found !!</strong> Please login and try agian. " +
                  "</div>";
            }
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
            else if(e.CommandName == "Move Cart")
            {

            }
        }

        private void deleterowdata(String rollno)
        {
            try
            {
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    Cart c = db.Carts.Find(int.Parse(rollno));
                    db.Carts.Remove(c);
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