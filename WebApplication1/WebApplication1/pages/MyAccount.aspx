<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="MyAccount.aspx.cs" Inherits="WebApplication1.pages.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h2>My account</h2>
        <p>My account details</p>
        <br>

        <div id="preview" runat="server"></div>
        <br>
        <br>
        <% WebApplication1.model.User user = WebApplication1.master.Site1.GetLogin(Response); %>
        <center>
      <%if (user == null)
          { %>
        <img src="../media/unknow_user.png" 
            class="img-circle" 
            alt="No User" 
            width="150" 
            height="150"> 
      <%}
          else
          {%>
        <img src="<%= "https://"+HttpContext.Current.Request.Url.Authority+"/Class/ProfilePicture.ashx?id=" + user.user_id%>" 
            class="img-circle" 
            alt="<%= user.first_name + " " + user.last_name %>" 
            width="150" 
            height="150"> 

      <%} %>
      </center>
        <br>
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
                        ReadOnly="true"
                        runat="server" />
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
                        ReadOnly="true"
                        runat="server" />
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
            Text="Update"
            OnClick="submitButton_Click" />
        <!--
         <a href="Login.aspx" 
             style="margin-right: 20px;" 
             class="btn btn-default">
             To Login Page
         </a>
        -->
    </div>
</asp:Content>
