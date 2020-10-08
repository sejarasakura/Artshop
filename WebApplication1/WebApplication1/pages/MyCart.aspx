<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="MyCart.aspx.cs" Inherits="WebApplication1.pages.MyCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%WebApplication1.model.User user = WebApplication1.master.Site1.GetLogin(Response); %>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <h2>My Cart</h2>
            <p>Look for more product go to <a href="Shop.aspx">Shop Now</a></p>
            <br>
            <div id="preview" runat="server"></div>
            <br>

            <%if (user != null)
                { %>
            <asp:Button
                Class="btn btn-secondary pull-right"
                Style="margin-bottom: 20px; margin-right: 20px;"
                ID="Button1"
                runat="server"
                Text="Select All"
                OnClick="selectButton_Click" />
            <asp:Button
                Class="btn btn-danger pull-right"
                Style="margin-bottom: 20px; margin-right: 20px;"
                ID="Button2"
                runat="server"
                Text="Select None"
                OnClick="deselectButton_Click" />
            <%} %>
            <div style="min-height:100px">
                <asp:GridView
                    CssClass="table table-hover"
                    ID="GridView1"
                    runat="server"
                    AllowPaging="True"
                    AutoGenerateColumns="False"
                    CellPadding="4"
                    ForeColor="#333333"
                    GridLines="None"
                    SelectedRowStyle-BackColor="#888888"
                    DataSourceID="SqlDataSource1"
                    OnRowCommand="GridView1_RowCommand"
                    OnPageIndexChanging="GridView1_PageIndexChanging"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowEditing="GridView1_RowEditing"
                    OnRowUpdating="GridView1_RowUpdating">
                    <Columns>
                        <asp:BoundField
                            DataField="cart_id"
                            HeaderText="Cart ID"
                            SortExpression="cart_id"
                            ReadOnly="True" />
                        <asp:TemplateField
                            HeaderText="Art Peview">
                            <ItemTemplate>
                                <asp:Image ID="Image1"
                                    Height="100"
                                    Width="100"
                                    runat="server"
                                    ImageUrl='<%# Eval("art_id", "~/Class/ArtPicGetter.ashx?id={0}")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField
                            DataField="Art Name"
                            HeaderText="Art Name"
                            ReadOnly="True"
                            SortExpression="Art Name" />
                        <asp:BoundField
                            DataField="Description"
                            HeaderText="Description"
                            ReadOnly="True"
                            SortExpression="Description" />
                        <asp:BoundField
                            DataField="Quantity"
                            HeaderText="Quantity"
                            SortExpression="Quantity" />
                        <asp:BoundField
                            DataField="Single Price"
                            HeaderText="Single Price"
                            ReadOnly="True"
                            SortExpression="Single Price" />
                        <asp:BoundField
                            DataField="Draw By"
                            HeaderText="Draw By"
                            ReadOnly="True"
                            SortExpression="Draw By" />
                        <asp:ButtonField CommandName="Delete Row" Text="Delete" />
                        <asp:CommandField ShowEditButton="True" />
                        <asp:TemplateField HeaderText="Select Art">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <SelectedRowStyle BackColor="#888888"></SelectedRowStyle>
                </asp:GridView>
                <asp:SqlDataSource
                    ID="SqlDataSource1"
                    runat="server"
                    ConnectionString="<%$ ConnectionStrings:ConnectionString3 %>"
                    SelectCommand="SELECT Art.art_id as art_id, Cart.cart_id AS cart_id, Art.image AS art_view, Art.name AS [Art Name], Art.description AS Description, Cart.quantity AS Quantity, Art.price AS [Single Price], [User].last_name + [User].first_name AS [Draw By] FROM Cart INNER JOIN Art ON Cart.art_id = Art.art_id INNER JOIN [User] ON Art.artist_id = [User].user_id WHERE (Cart.relation = @relation) AND (Cart.user_id = @user_id)"
                    DeleteCommand="DELETE FROM [Cart] WHERE (cart_id = @cart_id)"
                    UpdateCommand="UPDATE Cart SET quantity = @quantity WHERE (cart_id = @cart_id)">
                    <DeleteParameters>
                        <asp:Parameter Name="cart_id" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="C" Name="relation" Type="String" />
                        <asp:Parameter DefaultValue="" Name="user_id" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="quantity" />
                        <asp:Parameter Name="cart_id" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
        <%if (user != null)
            { %>
        <asp:Button
            Class="btn btn-success pull-right"
            ID="submitButton"
            runat="server"
            Text="Check Out"
            OnClick="submitButton_Click" />
        <%} %>
        </div>
        <div class="col-md-1"></div>

    </div>
    <% hide_btn(); %>
</asp:Content>
