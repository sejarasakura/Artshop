using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Net;

namespace WebApplication1.Class
{
    /// <summary>
    /// Summary description for Handler1
    /// </summary>
    public class Handler1 : IHttpHandler
    {
        // <%= HttpContext.Current.Request.Url.Authority %>/Class/ArtPicGetter.ashx?id=<%= unknow_id%>
        public void ProcessRequest(HttpContext context)
        {
            string id = context.Request.QueryString["id"].ToString();
            string sConn = "data source=(LocalDB)\\MSSQLLocalDB;attachdbfilename=|DataDirectory|\\ArtGalleryV2.mdf;integrated security=True;";
            SqlConnection objConn = new SqlConnection(sConn);
            objConn.Open();
            string sTSQL = "select [image] from [Art] where art_id=@id";
            SqlCommand objCmd = new SqlCommand(sTSQL, objConn);
            objCmd.CommandType = CommandType.Text;
            objCmd.Parameters.AddWithValue("@id", id.ToString());
            try
            {
                object data = objCmd.ExecuteScalar();
                if (data != null)
                {
                    context.Response.BinaryWrite((byte[])data);
                }
                else
                {
                    context.Response.BinaryWrite(FileToByteArray());
                }
                objConn.Close();
                objCmd.Dispose();
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
                imageBytes = webClient.DownloadData("https://" + HttpContext.Current.Request.Url.Authority + "/media/no_image.png");
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