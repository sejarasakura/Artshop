<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="WebApplication1.pages.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-1"></div>
        <div class="col-sm-10">
            <h2>My Order</h2>
            <p>Look for more product go to <a href="Shop.aspx">Shop Now</a></p>
            <br>
            <div id="preview" runat="server"></div>
            <br>

            <div id="SelectPaymentMethod" runat="server">
                <div class="container">
                    <br />
                    <br />
                    <!-- Trigger the modal with a button -->
                    <div class="row">
                        <div class="col-sm-4">
                            <button type="button"
                                class="btn btn-info btn-lg text-center btn-block"
                                data-toggle="modal"
                                data-target="#PaypalModal">
                                Continue With Paypal</button>
                        </div>
                        <div class="col-sm-4">
                            <button type="button"
                                class="btn btn-info btn-lg text-center btn-block"
                                data-toggle="modal"
                                data-target="#CardModal">
                                Continue With Credit Card</button>
                        </div>
                        <div class="col-sm-4">
                            <button type="button"
                                class="btn btn-info btn-lg text-center btn-block"
                                data-toggle="modal"
                                data-target="#BankTranferModal">
                                Continue With Bank Tranfer</button>
                        </div>
                    </div>
                </div>

                <!-- Modal -->
                <div class="modal" id="PaypalModal" role="dialog">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">
                                    <img src="../media/paypal.png" style="height: 50px; margin-right: 30px;">Paypal Check Out</h4>
                            </div>
                            <div class="modal-body">

                                <!--PayPalNumber-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="usr">PayPal Account :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="PayPalAccount"
                                                placeholder="Paypal Account"
                                                runat="server" />
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="PAYPAL"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator001"
                                                ControlToValidate="PayPalAccount"
                                                ErrorMessage="Please enter paypal account!" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="PAYPAL"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="PayPalAccount"
                                                ID="RegularExpressionValidator001"
                                                ValidationExpression="[0-9]{10}$"
                                                runat="server"
                                                ErrorMessage="The paypal account must be 10 number. " />
                                        </div>
                                    </div>
                                </div>


                                <!--Name-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="usr">Full Name :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="PayPalName"
                                                runat="server"
                                                Text=''>
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="PAYPAL"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator002"
                                                ControlToValidate="PayPalName"
                                                ErrorMessage="Please enter your full name!" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="PAYPAL"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="PayPalName"
                                                ID="RegularExpressionValidator002"
                                                ValidationExpression="[a-zA-Z ]{0,20}$"
                                                runat="server"
                                                ErrorMessage="The full name only accept max 20 word and must be character only" />
                                        </div>
                                    </div>
                                </div>


                                <!-- Email -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="usr">Email :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="PayPalMail"
                                                runat="server"
                                                Text=''>
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="PAYPAL"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator003"
                                                ControlToValidate="PayPalMail"
                                                ErrorMessage="Please enter your email!" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="PAYPAL"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="PayPalMail"
                                                ID="RegularExpressionValidator003"
                                                ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                runat="server"
                                                ErrorMessage="The email format is not correct" />
                                        </div>
                                    </div>
                                </div>


                                <!--Password-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="usr">Password :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="PayPalPass"
                                                runat="server"
                                                TextMode="Password"
                                                Text=''>
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="PAYPAL"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator004"
                                                ControlToValidate="PayPalPass"
                                                ErrorMessage="Please enter your password!" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="PAYPAL"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="PayPalPass"
                                                ID="RegularExpressionValidator004"
                                                ValidationExpression="[a-zA-Z0-9]{8,50}$"
                                                runat="server"
                                                ErrorMessage="The password only accept 8 to 50 word and must be number or character" />
                                        </div>
                                    </div>
                                </div>


                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                <asp:Button
                                    ValidationGroup="PAYPAL"
                                    CssClass="btn btn-success pull-right"
                                    Style="margin-left: 20px"
                                    Text="Continue Payment"
                                    runat="server"
                                    ID="Button3"
                                    OnClick="PayPalBtn_Click" />
                            </div>
                        </div>
                    </div>
                </div>





                <!-- Modal -->
                <div class="modal" id="CardModal" role="dialog">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">
                                    <img src="../media/card.png" style="height: 50px; margin-right: 30px;">
                                    Credit Card Check Out
                                </h4>
                            </div>
                            <div class="modal-body">


                                <!--CardNumber-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="usr">Card Number :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="CardNumber"
                                                placeholder="please enter card number!"
                                                runat="server" />
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="CARD"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator007"
                                                ControlToValidate="CardNumber"
                                                ErrorMessage="Please enter card number!" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="CARD"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="CardNumber"
                                                ID="RegularExpressionValidator007"
                                                ValidationExpression="[0-9]{16}$"
                                                runat="server"
                                                ErrorMessage="The card numbe rmust be 16 number. " />
                                        </div>
                                    </div>
                                </div>


                                <!--Name-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="usr">Full Name :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="CardName"
                                                runat="server"
                                                Text=''>
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="CARD"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator008"
                                                ControlToValidate="CardName"
                                                ErrorMessage="Please enter your full name!" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="CARD"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="CardName"
                                                ID="RegularExpressionValidator008"
                                                ValidationExpression="[a-zA-Z ]{0,20}$"
                                                runat="server"
                                                ErrorMessage="The full name only accept max 20 word and must be character only" />
                                        </div>
                                    </div>
                                </div>


                                <!--CCV and year month -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="usr">Exp Date :</label>
                                            <asp:TextBox
                                                type="date"
                                                CssClass="form-control"
                                                ID="CardExp"
                                                runat="server"
                                                Text=''>
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="CARD"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator009"
                                                ControlToValidate="CardExp"
                                                ErrorMessage="Please enter card exp date!" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="usr">CCV :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="CardCcv"
                                                runat="server"
                                                Text=''>
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="CARD"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator010"
                                                ControlToValidate="CardCcv"
                                                ErrorMessage="Please enter your ccv" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="CARD"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="CardCcv"
                                                ID="RegularExpressionValidator010"
                                                ValidationExpression="[0-9]{3}$"
                                                runat="server"
                                                ErrorMessage="CCV must be 3 number only" />
                                        </div>
                                    </div>
                                </div>


                                <!--Password-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="usr">Password :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="CardPass"
                                                runat="server"
                                                TextMode="Password"
                                                Text=''>
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="CARD"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator005"
                                                ControlToValidate="CardPass"
                                                ErrorMessage="Please enter your password!" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="CARD"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="CardPass"
                                                ID="RegularExpressionValidator005"
                                                ValidationExpression="[a-zA-Z0-9]{8,50}$"
                                                runat="server"
                                                ErrorMessage="The password only accept 8 to 50 word and must be number or character" />
                                        </div>
                                    </div>
                                </div>



                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                <asp:Button
                                    ValidationGroup="CARD"
                                    CssClass="btn btn-success pull-right"
                                    Style="margin-left: 20px"
                                    Text="Continue Payment"
                                    runat="server"
                                    ID="Button1"
                                    OnClick="CardBtn_Click" />
                            </div>
                        </div>
                    </div>
                </div>





                <!-- Modal -->
                <div class="modal" id="BankTranferModal" role="dialog">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">
                                    <img src="../media/bank.png" style="height: 50px; margin-right: 30px;">Bank Tranfer Check Out</h4>
                            </div>
                            <div class="modal-body">


                                <!--Bank Account-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="usr">Bank Account :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="BankAccount"
                                                placeholder="please enter the quantity"
                                                runat="server" />
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="BANK"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator013"
                                                ControlToValidate="BankAccount"
                                                ErrorMessage="Please enter card number!" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="BANK"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="BankAccount"
                                                ID="RegularExpressionValidator013"
                                                ValidationExpression="[0-9]{10}$"
                                                runat="server"
                                                ErrorMessage="The bank account must be 10 number. " />
                                        </div>
                                    </div>
                                </div>


                                <!--Name-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="usr">Full Name :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="BankName"
                                                runat="server"
                                                Text=''>
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="BANK"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator011"
                                                ControlToValidate="BankName"
                                                ErrorMessage="Please enter your full name!" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="BANK"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="BankName"
                                                ID="RegularExpressionValidator011"
                                                ValidationExpression="[a-zA-Z ]{0,20}$"
                                                runat="server"
                                                ErrorMessage="The full name only accept max 20 word and must be character only" />
                                        </div>
                                    </div>
                                </div>


                                <!-- UserName -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="usr">Full Name :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="BankUsername"
                                                runat="server"
                                                Text=''>
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="BANK"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator012"
                                                ControlToValidate="BankUsername"
                                                ErrorMessage="Please enter your username!" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="BANK"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="BankUsername"
                                                ID="RegularExpressionValidator012"
                                                ValidationExpression="[a-zA-Z]{0,20}$"
                                                runat="server"
                                                ErrorMessage="The username only accept max 20 word and must be character only" />
                                        </div>
                                    </div>
                                </div>


                                <!--Password-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="usr">Password :</label>
                                            <asp:TextBox
                                                CssClass="form-control"
                                                ID="BankPass"
                                                runat="server"
                                                TextMode="Password"
                                                Text=''>
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator
                                                ValidationGroup="BANK"
                                                ForeColor="Red"
                                                runat="server"
                                                ID="RequiredFieldValidator006"
                                                ControlToValidate="BankPass"
                                                ErrorMessage="Please enter your password!" />
                                            <asp:RegularExpressionValidator
                                                ValidationGroup="BANK"
                                                ForeColor="Red"
                                                Display="Dynamic"
                                                ControlToValidate="BankPass"
                                                ID="RegularExpressionValidator006"
                                                ValidationExpression="[a-zA-Z0-9]{8,50}$"
                                                runat="server"
                                                ErrorMessage="The password only accept 8 to 50 word and must be number or character" />
                                        </div>
                                    </div>
                                </div>



                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                <asp:Button
                                    ValidationGroup="BANK"
                                    CssClass="btn btn-success pull-right"
                                    Style="margin-left: 20px"
                                    Text="Continue Payment"
                                    runat="server"
                                    ID="Button4"
                                    OnClick="BankBtn_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <br />
                <br />
                <br />
                <br />
            </div>
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
                                    <HeaderTemplate>
                                        <td>Artist Name</td>
                                        <td>Art Tile</td>
                                        <td>Preview</td>
                                        <td>Quantity</td>
                                        <td>Single Price</td>
                                        <td>Total Price</td>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <div>
                                            <tr>
                                                <!-- Join Order Details and Art Where order_id = x-->
                                                <!-- artist_name as description -->
                                                <asp:Label ID="art_id" runat="server" Visible="false" Text='<%# Eval("art_id")%>' />
                                                <td><%# Eval("description").ToString().Split(';')[0] %></td>
                                                <td><%# Eval("name")  %></td>
                                                <td>
                                                    <asp:Image ID="Image1"
                                                        Height="100"
                                                        Width="100"
                                                        runat="server"
                                                        ImageUrl='<%# Eval("art_id", "~/Class/ArtPicGetter.ashx?id={0}")%>' />
                                                </td>
                                                <!-- description[1] as qantity -->
                                                <td>
                                                    <asp:Label ID="quantity_main" runat="server" Text='<%# Eval("description").ToString().Split((char)59)[1] %>'>
                                                    </asp:Label>
                                                    <asp:Label ID="error_m" runat="server" ForeColor="Red">
                                                    </asp:Label>
                                                </td>

                                                <td>
                                                    <asp:Label ID="price_lb" runat="server" Text='<%# Eval("price")%>'>
                                                    </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="price_total" runat="server" Text='<%# decimal.Parse(Eval("price").ToString()) * decimal.Parse(Eval("description").ToString().Split((char)59)[1])%>'>
                                                    </asp:Label>
                                                </td>
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
                                <asp:Button
                                    CssClass="btn btn-warning pull-right"
                                    Text="Make Payment"
                                    runat="server"
                                    ID="PaymentBtn"
                                    OnClick="PaymentBtn_Click"
                                    Enabled='<%# convert_paid_role(Eval("status").ToString()) == WebApplication1.model.PaymentStatus.NotPaid %>'
                                    Visible='<%# convert_paid_role(Eval("status").ToString()) == WebApplication1.model.PaymentStatus.NotPaid %>' />
                                <%-- Continue Paid --%>
                                <asp:Button
                                    CssClass="btn btn-success pull-right"
                                    Style="margin-left: 20px"
                                    Text="Continue Make Payment"
                                    runat="server"
                                    ID="Button1"
                                    Visible="false"
                                    OnClick="RePaymentBtn_Click" />
                                <asp:HyperLink
                                    CssClass="btn btn-warning pull-right"
                                    Text="Pay When Stock Advisable"
                                    runat="server"
                                    ID="Button2"
                                    Visible="false"
                                    NavigateUrl="MyOrder.aspx" />
                            </div>
                        </div>
                    </div>
                    <br />
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="col-sm-1"></div>
    </div>
</asp:Content>
