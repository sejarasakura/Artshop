<!--Jing Weiii -->

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WishList2.aspx.cs" Inherits="WebApplication1.WishList2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>My Wishlist</h1><br />
            <br />
            <br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Index" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None" AllowSorting="True" AllowPaging="True">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" />
                    <asp:BoundField DataField="ArtID" HeaderText="ArtID" SortExpression="ArtID" />
                    <asp:BoundField DataField="ArtistName" HeaderText="ArtistName" SortExpression="ArtistName" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                    <asp:BoundField DataField="Index" HeaderText="Index" InsertVisible="False" ReadOnly="True" SortExpression="Index" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <br />
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" SelectCommand="SELECT [ArtID], [ArtistName], [Amount], [Price], [Index] FROM [WishList] ORDER BY [Index]" DeleteCommand="DELETE FROM [WishList] WHERE [Index] = @Index" InsertCommand="INSERT INTO [WishList] ([ArtID], [ArtistName], [Amount], [Price]) VALUES (@ArtID, @ArtistName, @Amount, @Price)" UpdateCommand="UPDATE [WishList] SET [ArtID] = @ArtID, [ArtistName] = @ArtistName, [Amount] = @Amount, [Price] = @Price WHERE [Index] = @Index">
                <DeleteParameters>
                    <asp:Parameter Name="Index" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ArtID" Type="Int32" />
                    <asp:Parameter Name="ArtistName" Type="String" />
                    <asp:Parameter Name="Amount" Type="Int32" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ArtID" Type="Int32" />
                    <asp:Parameter Name="ArtistName" Type="String" />
                    <asp:Parameter Name="Amount" Type="Int32" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="Index" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Home.aspx">Back To Home Menu</asp:HyperLink>
        </div>
    </form>
</body>
</html>
