<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="WebApplication1.pages.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Change password</h2>
        <p>Not yet have Artwork Sales.com account ? <a href="#">Register Now</a></p>
        <br>
        <div id="preview" runat="server"></div>
        <br>
        <% GetPost(); GetUser();%>
        <%if (post == "0" || post == null)
            { %>
        <div runat="server" id="SendMail">

            <center> 
                
                <% if (user != null)
                    { %>
                <h1><%= user.first_name + " " + user.last_name %></h1>
                <br />
        <img src="<%= "https://" + HttpContext.Current.Request.Url.Authority + "/Class/ProfilePicture.ashx?id=" + user.user_id%>" 
            class="img-circle" 
            alt="<%= user.first_name + " " + user.last_name %>" 
            width="150" 
            height="150"> 
                <% }
                   else
                   {%>
        <img src="../media/unknow_user.png" 
            class="img-circle" 
            alt="No User" 
            width="150" 
            height="150"> 

                <% }%>

        </center>
            <br>
            <br>
            <div class="form-group">
                <label for="usr">Username or Email:</label>
                <asp:TextBox
                    CssClass="form-control"
                    ID="EmailText"
                    placeholder="Please enter email"
                    Text=""
                    runat="server" />
            </div>
            <br>
            <br>
            <asp:Button Class="btn btn-success pull-right" ID="Button1" runat="server" Text="Send Mail" OnClick="submitButton_Click" />
            <a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/Register.aspx" style="margin-right: 20px;" class="btn btn-default">Sign Up</a>
            <a href="Login.aspx" class="btn btn-info">To Login Page</a>
        </div>
        <%}
            else if (post.Length == 20)
            { %>
        <div runat="server" id="ChangePass">

            <center> 
                <% if (user != null)
                    { %>
                <h1><%= user.first_name + " " + user.last_name %></h1>
                <br />
        <img src="<%= "https://" + HttpContext.Current.Request.Url.Authority + "/Class/ProfilePicture.ashx?id=" + user.user_id%>" 
            class="img-circle" 
            alt="<%= user.first_name + " " + user.last_name %>" 
            width="150" 
            height="150"> 
                <% }
                   else
                   {%>
        <img src="../media/unknow_user.png" 
            class="img-circle" 
            alt="No User" 
            width="150" 
            height="150"> 

                <% }%>

        </center>
            <br>
            <br>
            <div class="form-group">
                <label for="usr">New Password:</label>
                <asp:TextBox
                    CssClass="form-control"
                    ID="PasswordText1"
                    placeholder="Please enter password"
                    Text=""
                    TextMode="Password"
                    runat="server" />
                <asp:RequiredFieldValidator
                    CssClass="alert alert-danger"
                    runat="server"
                    ID="RequiredFieldValidator7"
                    ControlToValidate="PasswordText1"
                    ErrorMessage="Password not allow empty!" />
                <asp:RegularExpressionValidator
                    CssClass="alert alert-danger"
                    Display="Dynamic"
                    ControlToValidate="PasswordText1"
                    ID="RegularExpressionValidator3"
                    ValidationExpression="[a-zA-Z0-9]{8,50}$"
                    runat="server"
                    ErrorMessage="The password only accept 8 to 50 word and must be number or character" />
            </div>
            <div class="form-group">
                <label for="usr">Confirm Password:</label>
                <asp:TextBox
                    CssClass="form-control"
                    ID="PasswordText2"
                    placeholder="Please confirm password"
                    Text=""
                    TextMode="Password"
                    runat="server" />
                <asp:RequiredFieldValidator
                    CssClass="alert alert-danger"
                    runat="server"
                    ID="RequiredFieldValidator1"
                    ControlToValidate="PasswordText2"
                    ErrorMessage="Password not allow empty!!" />
                <asp:RegularExpressionValidator
                    CssClass="alert alert-danger"
                    Display="Dynamic"
                    ControlToValidate="PasswordText2"
                    ID="RegularExpressionValidator1"
                    ValidationExpression="[a-zA-Z0-9]{8,50}$"
                    runat="server"
                    ErrorMessage="The password only accept 8 to 50 word and must be number or character" />
            </div>
            <br>
            <br>
            <asp:Button Class="btn btn-success pull-right" ID="Button2" runat="server" Text="Change Pssword" OnClick="submitButton_Click2" />
            <a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/Register.aspx" style="margin-right: 20px;" class="btn btn-default">Sign Up</a>
            <a href="Login.aspx" class="btn btn-info">To Login Page</a>
        </div>
        <%}
            else
            {
                somthing_wrong("alert-danger", "<strong>The page loaded have an error please try agian later!</strong> <a href=\"ChangePassword.aspx?post=0\">return back</a>");
            }%>
    </div>

</asp:Content>
