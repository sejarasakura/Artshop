using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Class;
using WebApplication1.master;

namespace WebApplication1.user_control
{
    public partial class Navigation : System.Web.UI.UserControl
    {
        public WebApplication1.model.User user;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string getMyAccount()
        {
            if (user == null)
                user = Site1.GetLogin(Response);

            if (user == null)
            {
                return "https://" + HttpContext.Current.Request.Url.Authority + "/pages/Login.aspx";
            }
            else
            {
                return "https://" + HttpContext.Current.Request.Url.Authority + "/pages/MyAccount.aspx";
            }
        }
        protected void logout(object sender, EventArgs e)
        {
            CookiesManage.RemoveCookie(Site1.LOGIN_ID_PHASE, "user_id");
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
            pages.WebForm2.clear();
        }
    }
}