<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Navigation.ascx.cs" Inherits="WebApplication1.user_control.Navigation" %>

        <div class="container-fluid">
            <div class="navbar-header">
                <a class="" href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>">
                    <img class="pull-left" src="../media/logo.png" alt="Flowers in Chania" width="64" height="50">
                </a>
                <a class="navbar-brand" href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>" style="padding-left: 30px">Artwork Sales.com
                </a>
            </div>
            <ul class="nav navbar-nav">
                <%user = WebApplication1.master.Site1.GetLogin(Response);%>

                <!--All user-->
                <li class="art-list"><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/Home.aspx">Home</a></li>

                <%
                    if (user != null)
                    {
                        if (!user.user_role.Equals("A"))
                        {
                %>

                <li class="art-list"><a href="<%= "https://" + HttpContext.Current.Request.Url.Authority%>/pages/Shop.aspx">Shop</a></li>

                <%
                    }
                %>
                <!--autorise user-->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">My Account<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li class=""><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/MyAccount.aspx">My Account details</a></li>
                        <li class=""><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/ChangePassword.aspx?post=0">Change Password</a></li>
                        <li class=""><a href="#" runat="server" onserverclick="logout">Logout</a></li>
                    </ul>
                </li>
                <%
                    if (user.user_role.Equals("C") || user.user_role.Equals("B"))
                    {
                %>
                <!-- Customer -->
                <li class="art-list"><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/MyGallery.aspx">My Gallery</a></li>
                <li class="art-list"><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/MyCart.aspx">My Cart</a></li>
                <li class="art-list"><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/MyOrder.aspx">My Order</a></li>
                <li class="art-list"><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/MyWishList.aspx">My Wish List</a></li>
                <%
                    }
                    else if (user.user_role.Equals("A") || user.user_role.Equals("B"))
                    {
                %>
                <!-- Artiest -->
                <li class="art-list"><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/AddArt.aspx">Add New Art</a></li>
                <li class="art-list"><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/ArtWorkSales.aspx">My Artwork</a></li>
                <li class="art-list"><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/MyGallery.aspx">My Gallery</a></li>
                <%
                        }
                    }
                    else
                    {
                %>
                <!--unautorise user-->
                <li class="art-list"><a href="<%= "https://" + HttpContext.Current.Request.Url.Authority%>/pages/Shop.aspx">Shop</a></li>
                <li class="art-list"><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/Register.aspx">Register</a></li>
                <li class="art-list"><a href="<%= "https://"+HttpContext.Current.Request.Url.Authority%>/pages/Login.aspx">Login</a></li>
                <%
                    }
                %>
            </ul>

            <div class="navbar-header pull-right">
                <a class="" href="<%= getMyAccount() %>">
                    <img src="<%= "https://"+HttpContext.Current.Request.Url.Authority+"/Class/ProfilePicture.ashx?id=" + (user == null ? -1 :user.user_id) %>" alt="<%= (user == null ? -1+ "" :user.user_id + user.first_name + user.last_name) %>"
                        width="50"
                        height="50"
                        class="img-circle">
                </a>
            </div>
        </div>