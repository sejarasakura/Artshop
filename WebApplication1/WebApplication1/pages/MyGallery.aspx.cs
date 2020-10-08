using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.model;

namespace WebApplication1.pages
{
    public partial class MyGallery : System.Web.UI.Page
    {
        public User user = null;
        public UserRole ur;
        public static List<Art> data = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                data = null;
                user = null;
            }

            if (data == null)
                ReadImage();
            Repeater1.DataSource = data;
            Repeater1.DataBind();
        }

        protected void ReadImage()
        {
            if (user == null)
                user = WebApplication1.master.Site1.GetLogin(Response);
            if (user == null)
                Response.Redirect("Login.aspx?id=0");

            ur = (UserRole)user.user_role.ToCharArray()[0];
            if (ur == UserRole.Artist)
            {
                // See what artist sale
                data = GetArtArtist();
            }
            else if (ur == UserRole.Both)
            {
                // see what artist sale
                // see what he buy 
                data.AddRange(GetArtArtist());
                data.AddRange(GetArtCustomer());
            }
            else if (ur == UserRole.Customer)
            {
                // see what customer buy
                data = GetArtCustomer();
            }
            else
            {
                Response.Redirect("Login.aspx?id=0");
            }
        }

        protected void inti_data()
        {

            if (data == null)
                this.ReadImage();

            Repeater1.DataSource = data;
            Repeater1.DataBind();

            if (data.Count <= 0)
            {
                somthing_wrong("alert-danger", "<h1 style='text-align: center'>Your Gallery is empty</h1>");
            }
        }

        private List<Art> GetArtArtist()
        {
            // read Art
            try
            {
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    // get order_id base on cust_id and check who paid
                    return db.Arts.SqlQuery(
                        "SELECT * FROM Art WHERE artist_id = @artist_id",
                        new SqlParameter("@artist_id", user.user_id)
                        ).ToList();
                }
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.ToString());
                preview.InnerHtml += "<strong>You had sql  error !!!</strong> !!" + e.Message + "<br />";
            }
            return null;
        }
        private List<Art> GetArtCustomer()
        {
            List<Art> result = new List<Art>();
            try
            {
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    // get order_id base on cust_id and check who paid
                    OrderDetail[] order_ary = db.OrderDetails.SqlQuery(
                        "SELECT OrderDetails.art_id AS art_id, " +
                        "[Order].order_id as order_id, " +
                        "OrderDetails.product_quantity AS product_quantity " +
                        "FROM [Payment], [Order], [OrderDetails] " +
                        "WHERE [Order].customer_id = @customer_id AND " +
                        "Payment.status = ('P') AND " +
                        "OrderDetails.order_id = [Order].order_id AND " +
                        "Payment.order_id = [Order].order_id",
                        new SqlParameter("@customer_id", user.user_id)
                        ).ToArray();
                    foreach (OrderDetail detail in order_ary)
                    {
                        result.Add(db.Arts.Find(detail.art_id));
                    }
                    return result;
                }
            }
            catch (Exception e)
            {
                somthing_wrong("btn btn-danger", "<strong>You had sql error !!!</strong> " + e.Message + "<br />");
            }
            return null;
        }
        protected void DownloadFile(object sender, EventArgs e)
        {
            int id = int.Parse((sender as LinkButton).CommandArgument);
            byte[] bytes;
            string fileName;
            string constr = "data source=(LocalDB)\\MSSQLLocalDB;attachdbfilename=|DataDirectory|\\ArtGalleryV2.mdf;integrated security=True;";
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "select [image], [name] from [Art] where art_id=@id";
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        sdr.Read();
                        bytes = (byte[])sdr["image"];
                        fileName = sdr["name"].ToString();
                    }
                    con.Close();
                }
            }
            string ct = GetMimeFromBytes(bytes);
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = ct;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName + ".jpg");
            Response.BinaryWrite(bytes);
            Response.Flush();
            Response.End();
        }
        public static int MimeSampleSize = 256;

        public static string DefaultMimeType = "application/octet-stream";

        [DllImport(@"urlmon.dll", CharSet = CharSet.Auto)]
        private extern static uint FindMimeFromData(
            uint pBC,
            [MarshalAs(UnmanagedType.LPStr)] string pwzUrl,
            [MarshalAs(UnmanagedType.LPArray)] byte[] pBuffer,
            uint cbSize,
            [MarshalAs(UnmanagedType.LPStr)] string pwzMimeProposed,
            uint dwMimeFlags,
            out uint ppwzMimeOut,
            uint dwReserverd
        );

        public static string GetMimeFromBytes(byte[] data)
        {
            try
            {
                uint mimeType;
                FindMimeFromData(0, null, data, (uint)MimeSampleSize, null, 0, out mimeType, 0);

                var mimePointer = new IntPtr(mimeType);
                var mime = Marshal.PtrToStringUni(mimePointer);
                Marshal.FreeCoTaskMem(mimePointer);

                return mime ?? DefaultMimeType;
            }
            catch
            {
                return DefaultMimeType;
            }
        }

        public void somthing_wrong(string css_class, string error)
        {
            preview.InnerHtml =
              "<div class=\"alert " + css_class + " alert-dismissible\">" +
                "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                error +
              "</div>";
        }
    }
}