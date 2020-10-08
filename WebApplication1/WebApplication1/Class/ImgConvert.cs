using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication1.Class
{
    public class ImgConvert
    {
        public static string convert_image(byte[] data)
        {
            return "data:Image/png;64base," +
                Convert.ToBase64String(data);
        }
    }
}