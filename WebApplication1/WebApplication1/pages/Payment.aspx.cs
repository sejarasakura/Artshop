using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.model;
using System.Data.Entity.Migrations;

namespace WebApplication1.pages
{
    public partial class Payment : System.Web.UI.Page
    {
        public int order_id = -1;
        public User user = null;
        public List<Art> orderDetail = null;
        public Dictionary<int, int> out_of_stock_arts = new Dictionary<int, int>();
        public decimal total_price_record;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetOrderId();
            if (!IsPostBack)
            {
                SelectPaymentMethod.Visible = false;
                this.RepeaterOrder.DataSource = OrderDataTable();
                this.RepeaterOrder.DataBind();
            }
            orderDetail = OrderDetailsDataTable(order_id);
        }

        protected void GetOrderId()
        {
            if (Request.QueryString["order"] == null)
            {
                order_id = -1;
            }
            else
            {
                string temp = Request.QueryString["order"].ToString();
                try
                {
                    order_id = int.Parse(temp);
                }
                catch
                {
                    order_id = -1;
                }
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
            GetOrderId();
            if (user == null)
                user = WebApplication1.master.Site1.GetLogin(Response);

            if (user == null)
                Response.Redirect("Login.aspx");

            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                string sql = "SELECT [Payment].payment_id, [Payment].order_id, [Payment].payment_method_id, [Payment].status, [Payment].total_price, [Order].order_date as payment_date " +
                    "FROM [Order], [Payment] WHERE customer_id = @customer_id AND [Order].order_id = [Payment].order_id AND [Payment].order_id = @order_id";
                var da = db.Payments.SqlQuery(sql, new SqlParameter("@customer_id", user.user_id), new SqlParameter("@order_id", order_id));
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
                "[User].first_name + ' ' + [User].last_name + ';' + " +
                "CONVERT(varchar(10),[OrderDetails].product_quantity) + ';' as [description], " +
                "Art.price as price, [Art].quantity as quantity, " +
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

        protected void RePaymentBtn_Click(object sender, EventArgs e)
        {
            // Update Order quantity
            conti_page_update_order();
            // Select Payment Method
            go_to_select_payment();
            // Do Payment And Update Payment Agian
            // Send Email Reciept ?
        }

        protected void PaymentBtn_Click(object sender, EventArgs e)
        {
            bool checked_stock = check_stock();
            if (!checked_stock)
            {
                refresh_page();
                somthing_wrong("alert-danger", "The part of stock is currentlly finish!! ");
                // Hide Payment Button 
                RepeaterOrder.Controls[0].FindControl("PaymentBtn").Visible = false;
                // Show Continus payment Button
                RepeaterOrder.Controls[0].FindControl("Button1").Visible = true;
                RepeaterOrder.Controls[0].FindControl("Button2").Visible = true;
                return;
            }
            // Select Payment Method
            go_to_select_payment();
            // Do Payment And Update Payment Agian
            // Send Email Reciept ?
        }

        private void conti_page_update_order()
        {
            Repeater rpt_child = RepeaterOrder.Controls[0].FindControl("RepeaterOrderDetails") as Repeater;
            Label art_id_lb, quantity_lb;
            int art_id = 0, qauntity;
            decimal price = 0;
            OrderDetail orderDetail;
            model.Payment payment;

            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                foreach (RepeaterItem ri in rpt_child.Items)
                {
                    art_id_lb = ri.FindControl("art_id") as Label;
                    quantity_lb = ri.FindControl("quantity_main") as Label;
                    art_id = int.Parse(art_id_lb.Text);
                    qauntity = int.Parse(quantity_lb.Text);
                    // calculate price
                    price += (decimal)(((decimal)qauntity) * db.Arts.Find(art_id).price);
                    // Update order details 
                    orderDetail = db.OrderDetails.Find(order_id, art_id);
                    db.OrderDetails.AddOrUpdate(orderDetail);
                    orderDetail.product_quantity = qauntity;
                }
                // Update payment
                var p = db.Payments.SqlQuery(
                    "SELECT * FROM [Payment] WHERE order_id = @order_id",
                    new SqlParameter("order_id", order_id));
                try
                {
                    payment = p.ToArray()[0];
                }
                catch
                {
                    somthing_wrong("alert-danger", "The payment could not find out!! ");
                    return;
                }
                payment.total_price = price;
                total_price_record = price;
                db.Payments.AddOrUpdate(payment);
                // save
                db.SaveChanges();
            }
        }
        private void refresh_page()
        {
            Repeater rpt_child = RepeaterOrder.Controls[0].FindControl("RepeaterOrderDetails") as Repeater;
            Label art_id_lb, quantity_lb, total_lb, error_m, price_lb;
            int key_value, extra, original_value, able_value;
            decimal price;

            foreach (RepeaterItem ri in rpt_child.Items)
            {
                art_id_lb = ri.FindControl("art_id") as Label;
                quantity_lb = ri.FindControl("quantity_main") as Label;
                total_lb = ri.FindControl("price_total") as Label;
                error_m = ri.FindControl("error_m") as Label;
                price_lb = ri.FindControl("price_lb") as Label;
                key_value = int.Parse(art_id_lb.Text);
                error_m.Text = "";
                if (!out_of_stock_arts.ContainsKey(key_value))
                    continue;

                extra = out_of_stock_arts[key_value];
                original_value = int.Parse(quantity_lb.Text);
                able_value = original_value - extra;
                price = ((decimal)able_value) * decimal.Parse(price_lb.Text);
                total_price_record = price;

                quantity_lb.Text = able_value + "";
                error_m.Text = "*Out of Stock remain " + able_value;
                total_lb.Text = String.Format("{0:0.00}", price);
            }
        }

        private bool check_stock()
        {
            bool result = true;
            out_of_stock_arts.Clear();
            foreach (Art art in orderDetail)
            {
                if (art.quantity >= int.Parse(art.description.Split(';')[1]))
                {
                    result &= true;
                }
                else
                {
                    result &= false;
                    out_of_stock_arts.Add(art.art_id, (int)(int.Parse(art.description.Split(';')[1]) - art.quantity));
                }
            }
            return result;
        }

        private void go_to_select_payment()
        {
            SelectPaymentMethod.Visible = true;

        }

        protected void PayPalBtn_Click(object sender, EventArgs e)
        {
            PayPal paypal;
            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                paypal = db.PayPals.Find(this.PayPalAccount.Text);
                if (paypal == null)
                {
                    somthing_wrong("alert-danger", "<strong>Your Paypal ID not found!!!</strong>");
                    return;
                }
                if (paypal.password != this.PayPalPass.Text)
                {
                    somthing_wrong("alert-danger", "<strong>Your Password enter is incorrect!!!</strong>");
                    return;
                }
                if (paypal.email != this.PayPalMail.Text)
                {
                    somthing_wrong("alert-danger", "<strong>Your Email enter is incorrect!!!</strong>");
                    return;
                }
                if (paypal.amount < total_price_record)
                {
                    somthing_wrong("alert-danger", "<strong>Your PayPal account has not enought amount!!!</strong>");
                    return;
                }

                paypal.amount = paypal.amount - total_price_record;
                db.PayPals.AddOrUpdate(paypal);

                PM_PayPal pM_PayPal = new PM_PayPal();
                if (db.PM_PayPal.Count() > 0)
                    pM_PayPal.payment_role_id = db.PM_PayPal.Max(i => i.payment_role_id) + 1;
                pM_PayPal.paypal_id = paypal.paypal_id;
                db.PM_PayPal.AddOrUpdate(pM_PayPal);

                PaymentMethod paymentMethod = get_payment_method(db, pM_PayPal.payment_role_id, PaymentRole.PayPal);
                db.PaymentMethods.AddOrUpdate(paymentMethod);

                db.SaveChanges();
                change_to_paid(paymentMethod.payment_method_id);
                sendMail("PayPal", "PayPal Account : " + paypal.paypal_id);
            }
        }
        protected void CardBtn_Click(object sender, EventArgs e)
        {
            Card card = new Card();
            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                card = db.Cards.Find(this.CardNumber.Text);
                if (card == null)
                {
                    somthing_wrong("alert-danger", "<strong>Your Card Number not found!!!</strong>");
                    return;
                }
                if (card.password != this.CardPass.Text)
                {
                    somthing_wrong("alert-danger", "<strong>Your Password is incorrect!!!</strong>");
                    return;
                }
                if (card.ccv != this.CardCcv.Text)
                {
                    somthing_wrong("alert-danger", "<strong>Your CCV is incorrect!!!</strong>");
                    return;
                }
                if (card.amount < total_price_record)
                {
                    somthing_wrong("alert-danger", "<strong>Your Bank account has not enought amount!!!</strong>");
                    return;
                }

                card.amount = card.amount - total_price_record;
                db.Cards.AddOrUpdate(card);

                //PM_Card pM_Card = new PM_Card();
                //if (db.PM_Card.Count() > 0)
                //    pM_Card.payment_role_id = db.PM_Card.Max(i => i.payment_role_id) + 1;
                //pM_Card.card_number = card.card_number;
                //db.PM_Card.AddOrUpdate(pM_Card);

                PaymentMethod paymentMethod = get_payment_method(db, 0, PaymentRole.Card);
                db.PaymentMethods.AddOrUpdate(paymentMethod);

                db.SaveChanges();
                change_to_paid(paymentMethod.payment_method_id);
                sendMail("Credit/Debit Card", "Card Number : " + card.card_number);
            }
        }
        protected void BankBtn_Click(object sender, EventArgs e)
        {
            BankTranfer bank = new BankTranfer();
            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                bank = db.BankTranfers.Find(this.BankAccount.Text);
                if (bank == null)
                {
                    somthing_wrong("alert-danger", "<strong>Your BankTranfer Number not found!!!</strong>");
                    return;
                }
                if (bank.password != this.BankPass.Text)
                {
                    somthing_wrong("alert-danger", "<strong>Your Password is incorrect!!!</strong>");
                    return;
                }
                if (bank.bank_username != this.BankUsername.Text)
                {
                    somthing_wrong("alert-danger", "<strong>Your CCV is incorrect!!!</strong>");
                    return;
                }
                if (bank.amount < total_price_record)
                {
                    somthing_wrong("alert-danger", "<strong>Your Bank account has not enought amount!!!</strong>");
                    return;
                }

                bank.amount = bank.amount - total_price_record;
                db.BankTranfers.AddOrUpdate(bank);


                PM_BankTranfer pM_BankTranfer = new PM_BankTranfer();
                if (db.PM_BankTranfer.Count() > 0)
                    pM_BankTranfer.payment_role_id = db.PM_BankTranfer.Max(i => i.payment_role_id) + 1;
                pM_BankTranfer.bank_account = bank.bank_account;
                db.PM_BankTranfer.AddOrUpdate(pM_BankTranfer);

                PaymentMethod paymentMethod = get_payment_method(db, pM_BankTranfer.payment_role_id, PaymentRole.Bank);
                db.PaymentMethods.AddOrUpdate(paymentMethod);

                db.SaveChanges();
                change_to_paid(paymentMethod.payment_method_id);
                sendMail("Direct Bank tarnfer", "Account : " + bank.bank_account);

                somthing_wrong("alert-success", "<strong>Your have done the payment you can check trough <a href=\"MyGallery.aspx\">My Gallery</a> to download or view puchased product!!!</strong>");
            }
        }

        private PaymentMethod get_payment_method(ArtGalleryV2Entities db, int payment_role_id ,PaymentRole paymentRole)
        {
            PaymentMethod pm = new PaymentMethod();
            if (db.PaymentMethods.Count() > 0)
                pm.payment_method_id = db.PaymentMethods.Max(i => i.payment_method_id);
            pm.payment_role_id = payment_role_id;
            pm.payment_role = "" + (char)paymentRole;
            if (user == null)
                user = master.Site1.GetLogin(Response);
            if (user == null)
                Response.Redirect("Login.aspx");
            pm.user_id = this.user.user_id;
            return pm;
        }

        private void change_to_paid(int payment_method_id)
        {
            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                model.Payment pay;
                var p = db.Payments.SqlQuery(
                    "SELECT * FROM [Payment] WHERE order_id = @order_id",
                    new SqlParameter("order_id", order_id));
                try
                {
                    pay = p.ToArray()[0];
                }
                catch
                {
                    somthing_wrong("alert-danger", "The payment could not find out!! ");
                    return;
                }
                pay.status = "" + (char)PaymentStatus.Paid;
                pay.payment_method_id = payment_method_id;
                db.Payments.AddOrUpdate(pay);
                db.SaveChanges();
            }
        }

        private void sendMail(string payment_mmethod, string payment_id)
        {
            var m_content = "";
            m_content += "Hi, Dear user " + user.username + ", <br /><br />";
            m_content += "Thank for your expense in our store and buy our expensive art<br />";
            m_content += "You have buy the folllowing art: <br /><table style=''>";
            m_content += "<tr>";
            m_content += "<th> Title </th>";
            m_content += "<th> Quantity </th>";
            m_content += "<th></th>";
            m_content += "<th> Single Price </th>";
            m_content += "</tr>";
            foreach (Art art in orderDetail)
            {
                m_content += "<tr>";
                m_content += "<td>" + art.name + "</td>";
                m_content += "<td>" + art.quantity + "</td>";
                m_content += "<td> * </td>";
                m_content += "<td>" + art.price + "</td>";
                m_content += "</tr>";
            }
            m_content += "</table>" +
                "Total payment : " + this.total_price_record + "<br />";
            m_content += "Paid By "+ payment_mmethod +" [ " + payment_id + " ]. <br />";
            m_content += "<br /><br />Thak you so much !!";

            bool sended = Class.SendMail.send_mail(
               "Placed Payment",
               "This notice confirms that your has purchase our product in Art Salse.com  !!",
               m_content,
               user.user_email
           );
        }
    }
}