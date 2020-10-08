using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Asignment
{
    public partial class buy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            String message = "Order detail ";
            {
                message += "3 </br> set3 </br>";
                lblSetDetail.Text = message;
            }
        }

        protected void calButton_Click(object sender, EventArgs e)
        {
            double total = 0;
            double subTotal1 = 0;
            double subTotal2 = 0;
            double subTotal3 = 0;
            int quantitySet2 = 0;
            int quantitySet1 = 0;
            int quantitySet3 = 0;

            if (quantity1.Text == "" && !choose1.Checked)
            {
                quantitySet1 = 0;
                subTotal1 = 0;
                lblPrice1.Text = "";

            }
            else
            {
                quantitySet1 = int.Parse(quantity1.Text);
                subTotal1 = 100.00 * quantitySet1;
                lblPrice1.Text = subTotal1.ToString();
            }

            if (quantity2.Text == "" && !choose2.Checked)
            {
                quantitySet2 = 0;
                subTotal2 = 0;
                lblPrice2.Text = "";

            }
            else
            {
                quantitySet2 = int.Parse(quantity2.Text);
                subTotal2 = 150.00 * quantitySet2;
                lblPrice2.Text = subTotal2.ToString();
            }

            if (quantity3.Text == "" && !choose3.Checked)
            {
                quantitySet3 = 0;
                subTotal3 = 0;
                lblPrice3.Text = "";

            }
            else
            {
                quantitySet3 = int.Parse(quantity3.Text);
                subTotal3 = 200.00 * quantitySet3;
                lblPrice3.Text = subTotal3.ToString();
            }

            total = subTotal1 + subTotal2 + subTotal3;

            lblPrice4.Text = total.ToString();
        }

        protected void cancelButton_Click(object sender, EventArgs e)
        {
            quantity1.Text = "";
            quantity2.Text = "";
            quantity3.Text = "";
            choose1.Checked = false;
            choose2.Checked = false;
            choose3.Checked = false;
            lblPrice1.Text = "";
            lblPrice2.Text = "";
            lblPrice3.Text = "";
            lblPrice4.Text = "";

        }

        protected void confirmButton_Click(object sender, EventArgs e)
        {

        }
    }
}