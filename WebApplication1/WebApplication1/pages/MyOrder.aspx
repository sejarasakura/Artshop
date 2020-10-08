<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="MyOrder.aspx.cs" Inherits="WebApplication1.pages.WebForm8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h2>My Order</h2>
        <p>Look for more product go to <a href="Shop.aspx">Shop Now</a></p>
        <br>
        <div id="preview" runat="server"></div>
        <br>
        <asp:Repeater
            ID="RepeaterOrder"
            runat="server" OnItemDataBound="RepeaterOrder_ItemDataBound">
            <ItemTemplate>
                <div class="well well-md">
                    <div class="row">
                        <div class="col-sm-6">
                        </div>
                        <div class="col-sm-6 text-right">
                            <h5>
                                <span class="label <%# convert_css_class(convert_paid_role(Eval("status").ToString())) %>" style="border-radius: 30px">
                                    <%# convert_user_role(Eval("status").ToString()) %>
                                </span>
                            </h5>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <%# Eval("payment_date", "{0:dddd, dd MMMM yyyy}")  %>
                        </div>
                        <div class="col-sm-6 text-right">
                            Manage order:
                            <asp:Literal ID="MyLiteral" runat="server" Text='<%# Eval("order_id")  %>' />
                        </div>
                    </div>
                    <table class="table table-striped">
                        <tbody>
                            <asp:Repeater
                                ID="RepeaterOrderDetails"
                                runat="server">
                                <ItemTemplate>
                                    <div>
                                        <tr>
                                            <!-- Join Order Details and Art Where order_id = x-->
                                            <!-- artist_name as description -->
                                            <td><%# Eval("description")  %></td>
                                            <td><%# Eval("name")  %></td>
                                            <td>
                                                <asp:Image ID="Image1"
                                                    Height="100"
                                                    Width="100"
                                                    runat="server"
                                                    ImageUrl='<%# Eval("art_id", "~/Class/ArtPicGetter.ashx?id={0}")%>' />
                                            </td>
                                            <!-- product_quantity as qantity -->
                                            <td><%# Eval("quantity")  %></td>
                                            <td><%# Eval("price")  %></td>
                                        </tr>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-sm-6">
                        </div>
                        <div class="col-sm-6">
                            <%-- Paid --%>
                            <asp:HyperLink
                                CssClass="btn btn-warning pull-right"
                                Text="Make Payment"
                                runat="server"
                                ID="PaymentBtn"
                                NavigateUrl='<%# "Payment.aspx?order=" + Eval("order_id") %>'
                                Enabled='<%# convert_paid_role(Eval("status").ToString()) == WebApplication1.model.PaymentStatus.NotPaid %>'
                                Visible='<%# convert_paid_role(Eval("status").ToString()) == WebApplication1.model.PaymentStatus.NotPaid %>' />
                            <%-- Cancle Order --%>
                            <asp:Button
                                CssClass="btn btn-danger pull-right"
                                Text="Cancel Order"
                                runat="server"
                                ID="CancleBtn"
                                CommandArgument='<%# Eval("order_id")  %>'
                                Enabled='<%# convert_paid_role(Eval("status").ToString()) == WebApplication1.model.PaymentStatus.Paid %>'
                                Visible='<%# convert_paid_role(Eval("status").ToString()) == WebApplication1.model.PaymentStatus.Paid %>' />
                        </div>
                    </div>
                </div>
                <br />
            </ItemTemplate>
            <FooterTemplate>
            </FooterTemplate>
        </asp:Repeater>
    </div>


</asp:Content>
