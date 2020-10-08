using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.model;

namespace WebApplication1.pages
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        public User user = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.RepeaterOrder.DataSource = OrderDataTable();
                this.RepeaterOrder.DataBind();
            }
        }

        protected void RepeaterOrder_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Literal MyLiteral = (Literal)e.Item.FindControl("MyLiteral");
            Repeater rpt_child = e.Item.FindControl("RepeaterOrderDetails") as Repeater;
            if (MyLiteral == null)
                return;
            try
            {
                rpt_child.DataSource = OrderDetailsDataTable(int.Parse(MyLiteral.Text));
                rpt_child.DataBind();
            }
            catch (Exception ex)
            {
                somthing_wrong("alert-danger", "<strong>You had occur an error in RepeaterOrder_ItemDataBound!!!</strong> " + ex.Message + "<br />");
            }
        }

        protected List<model.Payment> OrderDataTable()
        {
            if (user == null)
                user = WebApplication1.master.Site1.GetLogin(Response);

            if (user == null)
                Response.Redirect("Login.aspx");

            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                string sql = "SELECT [Payment].payment_id, [Payment].order_id, [Payment].payment_method_id, [Payment].status, [Payment].total_price, [Order].order_date as payment_date " +
                    "FROM [Order], [Payment] WHERE customer_id = @customer_id AND [Order].order_id = [Payment].order_id";
                var da = db.Payments.SqlQuery(sql, new SqlParameter("@customer_id", user.user_id));
                try
                {
                    return da.ToList();
                }
                catch (Exception ex)
                {
                    somthing_wrong("alert-danger", "<strong>You had occur an error while read order!!!</strong> " + ex.Message + "<br />");
                }
            }
            return null;
        }
        protected List<Art> OrderDetailsDataTable(int order_id)
        {
            string sql = "SELECT Art.art_id as art_id, Art.[image] as [image], " +
                "Art.artist_id as artist_id, Art.date_done as date_done, " +
                "[User].first_name + ' ' + [User].last_name as [description], " +
                "Art.price as price, [OrderDetails].product_quantity as quantity, " +
                "Art.[name] as [name] " +
                "FROM [Art], [OrderDetails], [User] " +
                "WHERE OrderDetails.order_id = @order_id AND " +
                "Art.artist_id = [User].[user_id] AND " +
                "Art.art_id = OrderDetails.art_id";
            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                var da = db.Arts.SqlQuery(sql, new SqlParameter("@order_id", order_id));
                try
                {
                    return da.ToList();
                }
                catch (Exception ex)
                {
                    somthing_wrong("alert-danger", "<strong>You had occur an error while OrderDetailsDataTable !!!</strong> " + ex.Message + "<br />");
                }
            }
            return null;
        }

        protected void somthing_wrong(string css_class, string error)
        {
            preview.InnerHtml =
              "<div class=\"alert " + css_class + " alert-dismissible\">" +
                "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                error +
              "</div>";
        }

        protected string convert_user_role(string user_r)
        {
            PaymentStatus userRole = (PaymentStatus)user_r.ToCharArray()[0];
            if (userRole == PaymentStatus.Paid)
                return "Paid";
            else if (userRole == PaymentStatus.NotPaid)
                return "Pendding Payment";
            else if (userRole == PaymentStatus.Cancled)
                return "Cancelled";
            else if (userRole == PaymentStatus.Refund)
                return "Refund";
            else
                return "Unkown";
        }
        protected PaymentStatus convert_paid_role(string user_r)
        {
            return (PaymentStatus)user_r.ToCharArray()[0];
        }
        protected string convert_css_class(PaymentStatus userRole)
        {
            if (userRole == PaymentStatus.Paid)
                return "label-success";
            else if (userRole == PaymentStatus.NotPaid)
                return "label-warning";
            else if (userRole == PaymentStatus.Cancled)
                return "label-danger";
            else if (userRole == PaymentStatus.Refund)
                return "label-success";
            else
                return "label-danger";
        }
    }
}