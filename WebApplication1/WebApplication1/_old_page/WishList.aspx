<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="WishList.aspx.cs" Inherits="WebApplication1.WishList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div>
            <div class="container">
            <h1>View Art Works</h1><br />
            <br />
            
            <asp:GridView CssClass="table" ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="art_id" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="art_id" HeaderText="art_id" InsertVisible="False" ReadOnly="True" SortExpression="art_id" />
                    <asp:BoundField DataField="artist_id" HeaderText="artist_id" SortExpression="artist_id" />
                    <asp:BoundField DataField="quantity" HeaderText="quantity" SortExpression="quantity" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Art] WHERE [art_id] = @art_id" InsertCommand="INSERT INTO [Art] ([artist_id], [quantity], [Price]) VALUES (@artist_id, @quantity, @Price)" SelectCommand="SELECT [art_id], [artist_id], [quantity], [Price] FROM [Art]" UpdateCommand="UPDATE [Art] SET [artist_id] = @artist_id, [quantity] = @quantity, [Price] = @Price WHERE [art_id] = @art_id">
                <DeleteParameters>
                    <asp:Parameter Name="art_id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="artist_id" Type="String" />
                    <asp:Parameter Name="quantity" Type="Int32" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="artist_id" Type="String" />
                    <asp:Parameter Name="quantity" Type="Int32" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="art_id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            Wish List Selection<br />
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="art_id" DataSourceID="SqlDataSource2" DefaultMode="Insert" ForeColor="#333333" GridLines="None" Height="50px" Width="125px">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="art_id" HeaderText="art_id" ReadOnly="True" SortExpression="art_id" InsertVisible="False" />
                    <asp:BoundField DataField="artist_id" HeaderText="artist_id" SortExpression="artist_id" />
                    <asp:BoundField DataField="quantity" HeaderText="quantity" SortExpression="quantity" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" DeleteCommand="DELETE FROM [Art] WHERE [art_id] = @art_id" InsertCommand="INSERT INTO [Art] ([artist_id], [quantity], [Price]) VALUES (@artist_id, @quantity, @Price)" SelectCommand="SELECT [art_id], [artist_id], [quantity], [Price] FROM [Art]" UpdateCommand="UPDATE [Art] SET [artist_id] = @artist_id, [quantity] = @quantity, [Price] = @Price WHERE [art_id] = @art_id">
                <DeleteParameters>
                    <asp:Parameter Name="art_id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="artist_id" Type="String" />
                    <asp:Parameter Name="quantity" Type="Int32" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="artist_id" Type="String" />
                    <asp:Parameter Name="quantity" Type="Int32" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="art_id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <br />
            <h1>
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/WishList2.aspx">To My Wishlist</asp:HyperLink>
            </h1>
            <br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Home.aspx">Back To Home Menu</asp:HyperLink>
            <br />
            <br />
                
            </div>
        </div>


</asp:Content>
