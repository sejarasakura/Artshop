using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1;
using WebApplication1.model;
using WebApplication1.Class;
using WebApplication1.pages;

namespace WebApplication1.master
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        public WebApplication1.model.User user;
        public static string LOGIN_ID_PHASE = "USER_LOGIN_ID";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public static Boolean IsLogin()
        {
            return CookiesManage.GetFromCookie(Site1.LOGIN_ID_PHASE, "user_id") != null;
        }
        public static User GetLogin(HttpResponse Response)
        {
            User result = null;
            string data = CookiesManage.GetFromCookie(Site1.LOGIN_ID_PHASE, "user_id");
            if (data != null)
            {
                int id = Int16.Parse(data);
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    result = db.Users.Find(id);
                }
            }
            return result;
        }
        protected void logout(object sender, EventArgs e)
        {
            CookiesManage.RemoveCookie(Site1.LOGIN_ID_PHASE, "user_id");
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
            pages.WebForm2.clear();
        }

        protected string getMyAccount()
        {
            if (user == null)
                user = GetLogin(Response);

            if (user == null)
            {
                return "https://" + HttpContext.Current.Request.Url.Authority + "/pages/Login.aspx";
            }
            else
            {
                return "https://" + HttpContext.Current.Request.Url.Authority + "/pages/MyAccount.aspx";
            }
        }
    }
}