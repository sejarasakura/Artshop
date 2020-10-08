using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;

namespace WebApplication1.Class
{
    public class SendMail
    {
        private static readonly string EMAIL_ACCOUNT = "ongtingwei847@gmail.com";
        private static readonly string EMAIL_PASSWORD = "tingwei123";
        public static int port = 587;
        public static bool send_mail(string title, string subject, string body, string des_email)
        {
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage(EMAIL_ACCOUNT, des_email);
            mail.Subject = subject;
            mail.Body = body;
            mail.SubjectEncoding = System.Text.Encoding.UTF8;
            mail.BodyEncoding = System.Text.Encoding.UTF8;
            mail.IsBodyHtml = true;
            SmtpClient client = new SmtpClient();
            client.Credentials = new NetworkCredential(EMAIL_ACCOUNT, EMAIL_PASSWORD);
            client.Port = port;
            client.Host = "smtp.gmail.com";
            client.EnableSsl = true;
            try
            {
                client.Send(mail);
                return true;
                //Page.RegisterStartupScript("UserMsg", "<script>alert('Successfully Send...');if(alert){ window.location='SendMail.aspx';}</script>");
            }
            catch (Exception ex)
            {
                Exception ex2 = ex;
                string errorMessage = string.Empty;
                while (ex2 != null)
                {
                    errorMessage += ex2.ToString();
                    ex2 = ex2.InnerException;
                }
                throw ex;
                //Page.RegisterStartupScript("UserMsg", "<script>alert('Sending Failed...');if(alert){ window.location='SendMail.aspx';}</script>");
            }
        }
    }
}