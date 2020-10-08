<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication1.pages.WebForm2" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Login</h2>
        <p>Not yet have Artwork Sales.com account ? <a href="#">Register Now</a></p>
        <%
            if (!submit)
            {
                WebApplication1.model.User user = WebApplication1.master.Site1.GetLogin(Response);
            }
            else
            {
                submit = false;
            }
        %>
        <br>
        <br>
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
        <div class="form-group">
            <label for="usr">Username or Email:</label>
            <asp:TextBox
                CssClass="form-control"
                ID="EmailText"
                placeholder="Please enter email or username"
                Text=""
                runat="server" />
        </div>
        <div class="form-group">
            <label for="pwd">Password:</label>
            <asp:TextBox
                Text=""
                CssClass="form-control"
                ID="PasswordText"
                placeholder="Please Enter Password"
                TextMode="Password"
                runat="server" />
        </div>
        <br>
        <br>
        <%if (user == null)
            { %>
        <asp:Button Class="btn btn-success pull-right" ID="submitButton" runat="server" Text="Next" OnClick="submitButton_Click" />
        <a href="Register.aspx" style="margin-right: 20px;" class="btn btn-default">Sign Up</a>
        <a href="ChangePassword.aspx?post=0" class="btn btn-warning">Forgot Password</a>
        <%}
        else
        { %>
        <a href="Home.aspx" class="btn btn-success pull-right">Confirm Login</a>
        <asp:Button Class="btn btn-danger pull-right" Style="margin-right: 20px;" ID="Button2" runat="server" Text="Logout" OnClick="logoutButton_Click" />
        <%} %>

        <div id="preview" runat="server"></div>
    </div>
</asp:Content>
