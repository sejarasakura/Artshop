using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;

namespace WebApplication1.Class
{
    /// <summary>
    /// Summary description for ProfilePicture
    /// </summary>
    public class ProfilePicture : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string id = context.Request.QueryString["id"].ToString();
            string sConn = "data source=(LocalDB)\\MSSQLLocalDB;attachdbfilename=|DataDirectory|\\ArtGalleryV2.mdf;integrated security=True;";
            SqlConnection objConn = new SqlConnection(sConn);
            objConn.Open();
            string sTSQL = "select [picture] from [User] where user_id=@id";
            SqlCommand objCmd = new SqlCommand(sTSQL, objConn);
            objCmd.CommandType = CommandType.Text;
            objCmd.Parameters.AddWithValue("@id", id.ToString());
            try
            {
                object data = objCmd.ExecuteScalar();
                objConn.Close();
                objCmd.Dispose();
                if(data!=null)
                    context.Response.BinaryWrite((byte[])data);
                else
                {
                    context.Response.BinaryWrite(FileToByteArray());
                }
            }
            catch
            {
                context.Response.BinaryWrite(FileToByteArray());
            }
        }
        private byte[] FileToByteArray()
        {
            byte[] imageBytes = null;
            using (var webClient = new WebClient())
            {
                imageBytes = webClient.DownloadData("https://" + HttpContext.Current.Request.Url.Authority + "/media/unknow_user.png");
            }
            return imageBytes;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}