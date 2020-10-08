<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="MyWishList.aspx.cs" Inherits="WebApplication1.pages.MyWishList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <h2>My Wish List</h2>
            <p>Look for more product go to <a href="Shop.aspx">Shop Now</a></p>
            <br>
            <div id="preview" runat="server"></div>
            <br>

            <%WebApplication1.model.User user = WebApplication1.master.Site1.GetLogin(Response); %>
            <asp:GridView
                CssClass="table table-hover"
                ID="GridView1"
                runat="server"
                AllowPaging="True"
                AutoGenerateColumns="False"
                CellPadding="4"
                DataSourceID="SqlDataSource1"
                ForeColor="#333333"
                GridLines="None"
                SelectedRowStyle-BackColor="#888888"
                OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:BoundField
                        DataField="cart_id"
                        HeaderText="Wish ID"
                        SortExpression="cart_id"
                        ReadOnly="True" />
                    <asp:TemplateField
                        HeaderText="Art Peview">
                        <ItemTemplate>
                            <asp:Image ID="Image1"
                                Height="200"
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
                        DataField="Single Price"
                        HeaderText="Single Price"
                        ReadOnly="True"
                        SortExpression="Single Price" />
                    <asp:BoundField
                        DataField="Draw By"
                        HeaderText="Draw By"
                        ReadOnly="True"
                        SortExpression="Draw By" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton
                                runat="server"
                                CssClass="btn btn-danger"
                                CommandName="Delete Row"
                                Text='Remove &#128148;' />
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
                    <asp:Parameter DefaultValue="W" Name="relation" Type="String" />
                    <asp:Parameter DefaultValue="" Name="user_id" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="quantity" />
                    <asp:Parameter Name="cart_id" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />

        </div>
        <div class="col-md-1"></div>

    </div>
</asp:Content>
