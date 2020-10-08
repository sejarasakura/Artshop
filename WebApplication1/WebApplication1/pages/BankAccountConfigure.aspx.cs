using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.model;

namespace WebApplication1.pages
{
    public partial class BankAccountConfigure : System.Web.UI.Page
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
                List<BankTranfer> num_cart = db.BankTranfers.ToList<BankTranfer>();
                int count = num_cart.Count;
                if (count > 0)
                {
                    BankTranfer c = db.BankTranfers.Find(num_cart.Last().bank_account);
                    bank_account = (Int64.Parse(c.bank_account) + 1);
                }
            }
            SqlDataSource1.InsertParameters["bank_account"].DefaultValue = bank_account.ToString();
            SqlDataSource1.InsertParameters["name"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxFullName")).Text;
            SqlDataSource1.InsertParameters["bank_username"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxUserName")).Text;
            SqlDataSource1.InsertParameters["amount"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxAmount")).Text;
            SqlDataSource1.InsertParameters["password"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxPassword")).Text;

            SqlDataSource1.Insert();
        }
    }
}