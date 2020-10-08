<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication1.pages.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Register</h2>
        <p>Have Artwork Sales.com account ? <a href="Login.aspx">Login Now</a></p>
        <br>
        <div id="preview" runat="server"></div>
        <br>


        <!--Email-->
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="usr">Email:</label>
                    <asp:TextBox
                        CssClass="form-control"
                        ID="EmailText"
                        placeholder="Please enter email or username"
                        Text=""
                        runat="server" />
                    <asp:RequiredFieldValidator
                        CssClass="alert alert-danger"
                        runat="server"
                        ID="RequiredFieldValidator5"
                        ControlToValidate="EmailText"
                        ErrorMessage="Please enter your email!" />
                    <asp:RegularExpressionValidator
                        CssClass="alert alert-danger"
                        ID="regexEmailValid"
                        runat="server"
                        ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        ControlToValidate="EmailText"
                        ErrorMessage="Invalid Email Format" />
                </div>
            </div>
        </div>

        <!--Username-->
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="usr">Username:</label>
                    <asp:TextBox
                        CssClass="form-control"
                        ID="UsernameText"
                        placeholder="Please enter username"
                        Text=""
                        runat="server" />
                    <asp:RequiredFieldValidator
                        CssClass="alert alert-danger"
                        runat="server"
                        ID="RequiredFieldValidator4"
                        ControlToValidate="UsernameText"
                        ErrorMessage="Please enter your username!" />
                    <asp:RegularExpressionValidator
                        CssClass="alert alert-danger"
                        Display="Dynamic"
                        ControlToValidate="UsernameText"
                        ID="RegularExpressionValidator6"
                        ValidationExpression="[a-zA-Z]{0,20}$"
                        runat="server"
                        ErrorMessage="The username only accept max 20 word and must be character only" />
                </div>
            </div>
        </div>

        <!--Name-->
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="usr">First Name:</label>
                    <asp:TextBox
                        CssClass="form-control"
                        ID="FNameText"
                        placeholder="eg. John"
                        Text=""
                        runat="server" />
                    <asp:RequiredFieldValidator
                        CssClass="alert alert-danger"
                        runat="server"
                        ID="RequiredFieldValidator3"
                        ControlToValidate="FNameText"
                        ErrorMessage="Please enter your first name!" />
                    <asp:RegularExpressionValidator
                        CssClass="alert alert-danger"
                        Display="Dynamic"
                        ControlToValidate="FNameText"
                        ID="RegularExpressionValidator4"
                        ValidationExpression="[a-zA-Z ]{0,20}$"
                        runat="server"
                        ErrorMessage="The first name only accept max 20 word and must be character only" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="usr">Last Name:</label>
                    <asp:TextBox
                        CssClass="form-control"
                        ID="LNameText"
                        placeholder="eg. Lee"
                        Text=""
                        runat="server" />
                    <asp:RequiredFieldValidator
                        CssClass="alert alert-danger"
                        runat="server"
                        ID="RequiredFieldValidator2"
                        ControlToValidate="LNameText"
                        ErrorMessage="Please enter your last name!" />
                    <asp:RegularExpressionValidator
                        CssClass="alert alert-danger"
                        Display="Dynamic"
                        ControlToValidate="LNameText"
                        ID="RegularExpressionValidator5"
                        ValidationExpression="[a-zA-Z ]{0,20}$"
                        runat="server"
                        ErrorMessage="The last name only accept max 20 word and must be character only" />
                </div>
            </div>
        </div>

        <!--Gender-->
        <!--User Type-->
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="usr">User Role:</label><br />
                    <asp:RadioButton CssClass="radio-inline" ID="CheckCustomer"
                        Text="Customer Only" GroupName="RadioGroup2" runat="server" />
                    <asp:RadioButton CssClass="radio-inline" ID="CheckArtist"
                        Text="Artist Only" GroupName="RadioGroup2" runat="server" />
                    <asp:RadioButton CssClass="radio-inline" ID="CheckBoth"
                        Text="Artist and Customer" GroupName="RadioGroup2" runat="server" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="usr">Gender:</label><br />
                    <asp:RadioButton CssClass="radio-inline" ID="Radio1" Text="Male"
                        GroupName="RadioGroup1" runat="server" />
                    <asp:RadioButton CssClass="radio-inline" ID="Radio2" Text="Female"
                        GroupName="RadioGroup1" runat="server" />
                </div>
            </div>
        </div>

        <!--Phone num-->
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="usr">Phone Number:</label>
                    <asp:TextBox
                        CssClass="form-control"
                        ID="PhoneNumber"
                        placeholder="eg 60183927135 or 0183927135"
                        Text=""
                        runat="server" />
                    <asp:RequiredFieldValidator
                        CssClass="alert alert-danger"
                        runat="server"
                        ID="RequiredFieldValidator"
                        ControlToValidate="PhoneNumber"
                        ErrorMessage="Please enter your phone number!" />
                    <asp:RegularExpressionValidator
                        CssClass="alert alert-danger"
                        Display="Dynamic"
                        ControlToValidate="PhoneNumber"
                        ID="RegularExpressionValidator1"
                        ValidationExpression="^[\d]{10,11}$"
                        runat="server"
                        ErrorMessage="Format need 10-11 number only accept" />
                </div>
            </div>
        </div>

        <!--Password-->
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="pwd">Password:</label>
                    <asp:TextBox
                        Text=""
                        CssClass="form-control"
                        ID="PasswordText"
                        placeholder="Please Enter Password"
                        TextMode="Password"
                        runat="server" />
                    <asp:RequiredFieldValidator
                        CssClass="alert alert-danger"
                        runat="server"
                        ID="RequiredFieldValidator6"
                        ControlToValidate="PasswordText"
                        ErrorMessage="Please enter your password!" />
                    <asp:RegularExpressionValidator
                        CssClass="alert alert-danger"
                        Display="Dynamic"
                        ControlToValidate="PasswordText"
                        ID="RegularExpressionValidator2"
                        ValidationExpression="[a-zA-Z0-9]{8,50}$"
                        runat="server"
                        ErrorMessage="The password only accept 8 to 50 word and must be number or character" />
                </div>
            </div>
        </div>

        <!--Confirm Password-->
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="pwd">Confirm Password:</label>
                    <asp:TextBox
                        Text=""
                        CssClass="form-control"
                        ID="PasswordText2"
                        placeholder="Please Reenter Confrim Your Password"
                        TextMode="Password"
                        runat="server" />
                    <asp:RequiredFieldValidator
                        CssClass="alert alert-danger"
                        runat="server"
                        ID="RequiredFieldValidator7"
                        ControlToValidate="PasswordText2"
                        ErrorMessage="Please reenter the password agian!" />
                    <asp:RegularExpressionValidator
                        CssClass="alert alert-danger"
                        Display="Dynamic"
                        ControlToValidate="PasswordText2"
                        ID="RegularExpressionValidator3"
                        ValidationExpression="[a-zA-Z0-9]{8,50}$"
                        runat="server"
                        ErrorMessage="The password only accept 8 to 50 word and must be number or character" />
                </div>
            </div>
        </div>

        <!--Load Picture-->
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="pwd">Upload Profile Picture:</label>
                    <asp:FileUpload
                        text=""
                        CssClass="form-control"
                        ID="FileUpload"
                        placeholder="Upload your profile picture"
                        runat="server" />
                </div>
            </div>
        </div>

        <br>
        <br>
        <asp:Button
            Class="btn btn-success pull-right"
            ID="submitButton"
            runat="server"
            Text="Register"
            OnClick="submitButton_Click" />
        <a href="Login.aspx" style="margin-right: 20px;" class="btn btn-default">To Login Page</a>
    </div>
</asp:Content>
