using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.model;

namespace WebApplication1.pages
{
    public partial class MyCart : System.Web.UI.Page
    {
        private int order_id = -1;
        private int payment_id = -1;
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
            if (!Page.IsPostBack)
            {
                DataTable dt = (DataTable)GridView1.DataSource;
                Session["TaskTable"] = dt;
            }
            hide_btn();
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
        protected void selectButton_Click(object sender, EventArgs e)
        {
            preview.InnerHtml = "";
            foreach (GridViewRow row in GridView1.Rows)
            {
                var checkbox = row.FindControl("CheckBox1") as CheckBox;
                checkbox.Checked = true;
            }
        }
        protected void deselectButton_Click(object sender, EventArgs e)
        {
            preview.InnerHtml = "";
            foreach (GridViewRow row in GridView1.Rows)
            {
                var checkbox = row.FindControl("CheckBox1") as CheckBox;
                checkbox.Checked = false;
            }
        }
        protected void submitButton_Click(object sender, EventArgs e)
        {
            bool done_all = true;
            bool __add_order = false;
            float price = 0.0f;

            preview.InnerHtml =
              "<div class=\"alert alert-info alert-dismissible\">" +
                "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>";
            foreach (GridViewRow row in GridView1.Rows)
            {
                var checkbox = row.FindControl("CheckBox1") as CheckBox;
                if (checkbox.Checked)
                {
                    if (!__add_order)
                    {
                        done_all &= add_order();
                        __add_order = true;
                    }
                    using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                    {
                        string textCartId = row.Cells[0].Text;
                        string textPrice = row.Cells[5].Text;
                        Cart c = db.Carts.Find(int.Parse(textCartId));
                        cart_list.Add(c);
                        if (order_id == -1)
                            return;
                        done_all &= add_order_details(order_id, c.art_id, c.quantity ?? 0);
                        price += calc_price(float.Parse(textPrice), c.quantity ?? 0);
                    }
                }
            }
            preview.InnerHtml += "</div>";
            if (done_all && __add_order)
            {
                preview.InnerHtml +=
                  "<div class=\"alert alert-success alert-dismissible\">" +
                    "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                    "<strong>Order submitedl!</strong> done updating !!" +
                  "</div>";
                // remove cart
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    model.Payment p = db.Payments.Find(payment_id);
                    p.total_price = (decimal?)price;
                    db.Payments.AddOrUpdate(p);
                    foreach (Cart x in cart_list)
                    {
                        try
                        {
                            db.Carts.Remove(db.Carts.Find(x.cart_id));
                        }
                        catch
                        {

                        }
                    }
                    db.SaveChanges();
                }
                // continue payment
                if (__add_order)
                    Response.Redirect("Payment.aspx?order=" + order_id);
                else
                {
                    preview.InnerHtml =
                      "<div class=\"alert alert-danger alert-dismissible\">" +
                        "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                        "<strong>No Order Selected!</strong> please select and try agian !!" +
                      "</div>";
                }
            }
            else
            {
                preview.InnerHtml +=
                  "<div class=\"alert alert-danger alert-dismissible\">" +
                    "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                    "<strong>Submit order fail!</strong> please try agian !!" +
                  "</div>";
                // delete failer
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    foreach (OrderDetail x in order_de)
                    {
                        try
                        {
                            db.OrderDetails.Remove(x);
                        }
                        catch { }
                    }
                    try
                    {
                        db.Orders.Remove(db.Orders.Find(order_id));
                    }
                    catch { }
                }
            }
        }
        private bool add_order()
        {
            try
            {
                WebApplication1.model.User user = WebApplication1.master.Site1.GetLogin(Response);
                Order order = new Order();
                model.Payment payment = new model.Payment();

                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    // Add order
                    List<Order> num_cart = db.Orders.ToList<Order>();
                    int count = num_cart.Count;
                    if (count > 0)
                    {
                        Order c = db.Orders.Find(num_cart.Last().order_id);
                        order.order_id = (c.order_id + 1);
                    }
                    order_id = order.order_id;
                    order.customer_id = user.user_id;
                    order.order_date = DateTime.Now;
                    db.Orders.Add(order);

                    List<model.Payment> num_payment = db.Payments.ToList<model.Payment>();
                    count = num_payment.Count;
                    if (count > 0)
                    {
                        model.Payment p = db.Payments.Find(num_payment.Last().payment_id);
                        payment.payment_id = p.payment_id + 1;
                    }
                    payment_id = payment.payment_id;
                    payment.order_id = order_id;
                    payment.payment_method_id = -1;
                    payment.status = "" + (char)PaymentStatus.NotPaid;
                    db.Payments.Add(payment);

                    db.SaveChanges();
                    preview.InnerHtml = "<strong><strong>Submit Order Sucessful!</strong> done updating !!<br />";

                    return true;
                }
            }
            catch (Exception e)
            {
                preview.InnerHtml = "<strong>Submit Order Fail!</strong> please try agian !!" + e.Message + "<br />";
                return false;
            }
        }
        private bool add_order_details(int order_id, int art_id, int quantity)
        {
            try
            {
                WebApplication1.model.User user = WebApplication1.master.Site1.GetLogin(Response);
                OrderDetail order = new OrderDetail();

                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    order.art_id = art_id;
                    order.order_id = order_id;
                    order.product_quantity = quantity;
                    db.OrderDetails.Add(order);
                    order_de.Add(order);
                    db.SaveChanges();
                    preview.InnerHtml +="<strong>"+ quantity +"Product submited Sucessful!</strong> !!" +"<br />";

                    return true;
                }
            }
            catch (Exception e)
            {
                preview.InnerHtml += "<strong>Submit Order Fail!</strong> please try agian !!" + e.Message+"<br />";
                return false;
            }
        }
        private float calc_price(float price, int quantity)
        {
            return quantity * price;
        }
        private void update_role(int rollno)
        {
            string textID = GridView1.Rows[rollno].Cells[0].Text;
            string textQun = ((TextBox)GridView1.Rows[rollno].Cells[4].Controls[0]).Text;
            try
            {
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    Cart c = db.Carts.Find(int.Parse(textID));
                    c.quantity = int.Parse(textQun);
                    db.Carts.AddOrUpdate(c);
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
        protected void hide_btn()
        {
        }
    }
}