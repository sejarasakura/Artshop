using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.model;

namespace WebApplication1.pages
{
    public partial class CardConfigure : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void lbInsert_Click(object sender, EventArgs e)
        {
            Int64 card_number = 0;
            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                // Add order
                List<Card> num_cart = db.Cards.ToList<Card>();
                int count = num_cart.Count;
                if (count > 0)
                {
                    Card c = db.Cards.Find(num_cart.Last().card_number);
                    card_number = (Int64.Parse(c.card_number) + 1);
                }
            }
            SqlDataSource1.InsertParameters["card_number"].DefaultValue = String.Format("{0:D16}",card_number);
            SqlDataSource1.InsertParameters["name"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxFullName")).Text;
            SqlDataSource1.InsertParameters["ccv"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxCCV")).Text;
            SqlDataSource1.InsertParameters["amount"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxAmount")).Text;
            SqlDataSource1.InsertParameters["password"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxPassword")).Text;
            SqlDataSource1.InsertParameters["exp_date"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("TextBoxExp")).Text;

            SqlDataSource1.Insert();
        }
    }
}