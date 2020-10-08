<!--John Leeeeeeeee-->

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewbuydetail.aspx.cs" Inherits="Asignment.viewbuydetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            This is to confirm that you have ordered:
            <br />
            <br />
            <asp:Label ID="lblOrder" runat="server" Text=" "></asp:Label>
            <br />
            <br />
            The time now
            <asp:Label ID="lblTimeNow" runat="server" Text=" "></asp:Label>
            . You will receive your order within  3 days until 7 days.<br />
            We will reach at your doorstep before or at
            <asp:Label ID="lblReceiveTime" runat="server" Text=" "></asp:Label>
            .<br />
            <br />
            <br />
            <br />
            Thank you.</div>
    </form>
</body>

</html>
