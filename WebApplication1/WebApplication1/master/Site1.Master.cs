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
using System.Web.Security;

namespace WebApplication1.master
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        public static string LOGIN_ID_PHASE = "USER_LOGIN_ID";
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            DynamicSiteMapProvider myCustomSiteMap = new DynamicSiteMapProvider();
            myCustomSiteMap.RebuildSiteMap();
            myCustomSiteMap.GenerateWebDotSiteMapXMLFile();

            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }
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

    }
}