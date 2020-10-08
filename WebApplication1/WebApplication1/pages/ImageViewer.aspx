<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImageViewer.aspx.cs" Inherits="WebApplication1.pages.WebForm7" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="background-color:black">
<head runat="server">
    <title></title>
</head>
<body style="background-color:black">
    <style>
        .img-control{
            height: 100vh;
    min-height: 100vh;
    max-height: 100vh;
        }
        body, html{
            
    height: 100vh;
    min-height: 100vh;
    max-height: 100vh;
        }
    </style>
    <form id="form1" runat="server">
        <div style="height: 100%">
            <center>
            <img class="img-control" 
                src="../Class/ArtPicGetter.ashx?id=<%= Request.QueryString["id"].ToString()%>" 
                alt="<%= Request.QueryString["name"].ToString() %>"
                 />
                </center>
        </div>
    </form>
</body>
</html>
