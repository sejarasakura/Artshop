using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplication1.master;

namespace WebApplication1.Class
{
    public class CookiesManage
    {
        public static void RemoveCookie(string cookieName, string keyName)
        {
            // set dictionary
            Dictionary<string, string> data = new Dictionary<string, string>();
            data.Add("user_id", "");
            // set date 
            DateTime now = DateTime.UtcNow;
            // set cookies
            CookiesManage.StoreInCookie(Site1.LOGIN_ID_PHASE, data, now.AddMinutes(30.0), false);
        }

        public static void StoreInCookie(
            string cookieName,
            Dictionary<string, string> keyValueDictionary,
            DateTime? expirationDate,
            bool httpOnly = false)
        {
            HttpCookie cookie = HttpContext.Current.Response.Cookies[cookieName]
                ?? HttpContext.Current.Request.Cookies[cookieName];
            if (cookie == null) cookie = new HttpCookie(cookieName);
            if (keyValueDictionary == null || keyValueDictionary.Count == 0)
                cookie.Value = null;
            else
                foreach (var kvp in keyValueDictionary)
                    cookie.Values.Set(kvp.Key, kvp.Value);
            if (expirationDate.HasValue) cookie.Expires = expirationDate.Value;
            if (httpOnly) cookie.HttpOnly = true;
            HttpContext.Current.Response.Cookies.Set(cookie);
        }

        public static string GetFromCookie(string cookieName, string keyName)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];
            if (cookie != null)
            {
                string val = (!String.IsNullOrEmpty(keyName)) ? cookie[keyName] : cookie.Value;
                if (!String.IsNullOrEmpty(val)) return Uri.UnescapeDataString(val);
            }
            return null;
        }

        public static bool CookieExist(string cookieName, string keyName)
        {
            HttpCookieCollection cookies = HttpContext.Current.Request.Cookies;
            return (String.IsNullOrEmpty(keyName))
                ? cookies[cookieName] != null
                : cookies[cookieName] != null && cookies[cookieName][keyName] != null;
        }
    }
}