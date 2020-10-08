<!--Han ming -->
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="buy.aspx.cs" Inherits="Asignment.buy" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Artwork Sales.COM</h2>
            <p>Order your selected Artwork online. Online order starts 6.00am - 12am everyday.</p>
            <p>&nbsp;</p>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ArtID" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="ArtID" HeaderText="ArtID" InsertVisible="False" ReadOnly="True" SortExpression="ArtID" />
                    <asp:BoundField DataField="ArtistName" HeaderText="ArtistName" SortExpression="ArtistName" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Art] WHERE [ArtID] = @ArtID" InsertCommand="INSERT INTO [Art] ([ArtistName], [Art], [Amount], [Price]) VALUES (@ArtistName, @Art, @Amount, @Price)" SelectCommand="SELECT * FROM [Art]" UpdateCommand="UPDATE [Art] SET [ArtistName] = @ArtistName, [Art] = @Art, [Amount] = @Amount, [Price] = @Price WHERE [ArtID] = @ArtID">
                <DeleteParameters>
                    <asp:Parameter Name="ArtID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ArtistName" Type="String" />
                    <asp:Parameter Name="Art" Type="Object" />
                    <asp:Parameter Name="Amount" Type="Int32" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ArtistName" Type="String" />
                    <asp:Parameter Name="Art" Type="Object" />
                    <asp:Parameter Name="Amount" Type="Int32" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="ArtID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="lblSetDetail" runat="server" Text=" "></asp:Label>
            <br />
            <table>
            <tr>
                <td class="auto-style2"> </td>
                <td class="auto-style3">Quantity </td>
                <td class="auto-style2">Total (RM)</td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="choose1" runat="server" Text="1"/></td>
                <td class="auto-style1">
                    <asp:TextBox ID="quantity1" runat="server" Width="60px"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="lblPrice1" runat="server" Text=" " Width="88px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="choose2" Text="2" runat="server" /></td>
                <td class="auto-style1">
                    <asp:TextBox ID="quantity2" runat="server" Width="60px"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="lblPrice2" runat="server" Text=" " Width="89px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style4">
                    <asp:CheckBox ID="choose3" Text="3" runat="server" /></td>
                <td class="auto-style5">
                    <asp:TextBox ID="quantity3" runat="server" Width="62px"></asp:TextBox>
                </td>
                <td class="auto-style4">
                    <asp:TextBox ID="lblPrice3" runat="server" Text=" " Width="89px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td class="auto-style1">Total (RM) </td>
                <td>
                    <asp:Label ID="lblPrice4" runat="server" Text=" "></asp:Label>
                </td>
            </tr>
        </table>
            <br />
            <br />
        <asp:Button ID="calButton" runat="server" Text="Calculate" OnClick="calButton_Click" />
        &nbsp<asp:Button ID="cancelButton" runat="server" Text="Cancel" OnClick="cancelButton_Click" />
        <br />
        <br />
        <asp:Button ID="confirmButton" runat="server" Text="Confirm Order" OnClick="confirmButton_Click" PostBackUrl="~/viewbuydetail.aspx" />
        </div>
    </form>
</body>
</html>
