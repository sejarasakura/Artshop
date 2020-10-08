using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Asignment
{
    public partial class viewbuydetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (PreviousPage != null && PreviousPage.IsCrossPagePostBack)
            {
                TextBox quantity1 = PreviousPage.FindControl("quantity1") as TextBox;
                TextBox quantity2 = PreviousPage.FindControl("quantity2") as TextBox;
                TextBox quantity3 = PreviousPage.FindControl("quantity3") as TextBox;
                Label set1 = PreviousPage.FindControl("lblPrice1") as Label;
                Label set2 = PreviousPage.FindControl("lblPrice2") as Label;
                Label set3 = PreviousPage.FindControl("lblPrice3") as Label;
                Label total = PreviousPage.FindControl("lblPrice4") as Label;

                String message = " ";

                if (quantity1.Text != null)
                {
                    message += quantity1.Text + " -  1</br>";
                }

                if (quantity2.Text != null)
                {
                    message += quantity2.Text + " -  2</br>";
                }


                if (quantity3.Text != null)
                {
                    message += quantity3.Text + " -  3</br>";
                }

                message += "Total Price =RM " + total.Text;
                lblOrder.Text = message;
                lblTimeNow.Text = DateTimeOffset.UtcNow.ToString();
                lblReceiveTime.Text = DateTimeOffset.UtcNow.AddDays(7).ToString();
            }
        }
    }
}