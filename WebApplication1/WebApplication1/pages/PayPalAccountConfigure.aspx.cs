using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.model;

namespace WebApplication1.pages
{
    public partial class PayPalAccountConfigure : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void lbInsert_Click(object sender, EventArgs e)
        {
            Int64 bank_account = 0;
            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                // Add order
                List<PayPal> num_cart = db.PayPals.ToList<PayPal>();
                int count = num_cart.Count;
                if (count > 0)
                {
                    PayPal c = db.PayPals.Find(num_cart.Last().paypal_id);
                    bank_account = (Int64.Parse(c.paypal_id) + 1);
                }
            }
            SqlDataSource1.InsertParameters["paypal_id"].DefaultValue = bank_account.ToString();
            SqlDataSource1.InsertParameters["name"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxFullName")).Text;
            SqlDataSource1.InsertParameters["email"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxMail")).Text;
            SqlDataSource1.InsertParameters["amount"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxAmount")).Text;
            SqlDataSource1.InsertParameters["password"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxPassword")).Text;

            SqlDataSource1.Insert();
        }
    }
}