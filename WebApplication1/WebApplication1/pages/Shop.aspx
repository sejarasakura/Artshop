<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="WebApplication1.pages.WebForm1" %>

<%@ Import Namespace="WebApplication1.model" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Art Store</h2>
        <p>Dont forgot like and subcribe our page ? </p>

        <br>
        <div id="preview" runat="server"></div>
        <br>

        <!--Email-->
        <%
            using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
            {
                Art[] arts = db.Arts.ToArray();
                for (int i = 0; i < arts.Length; i++)
                {
                    if ((i + 1) % 3 == 0)
                    {
        %>
        <div class="row">
            <%
                }
            %>
            <div class="col-lg-4 col-sm-4">
                <a style="color: inherit; text-decoration: none" href="<%= "https://" + HttpContext.Current.Request.Url.Authority %>/pages/SingleProduct.aspx?id=<%=arts[i].art_id%>">
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <h4><%= arts[i].name%></h4>
                        </div>
                        <div class="panel-body">
                            <img
                                class="pull-left"
                                src="<%= "https://" + HttpContext.Current.Request.Url.Authority %>/Class/ArtPicGetter.ashx?id=<%=arts[i].art_id%>"
                                alt="<%= arts[i].name%>"
                                width="100%"
                                height="auto">
                        </div>
                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-12">
                                    <p>
                                        <i>
                                            <% %>
                                            <%= arts[i].description.Substring(0,arts[i].description.Length < 80 ?arts[i].description.Length:80)%>...
                                        </i>
                                    </p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-8">
                                    <p><b>RM <%= Decimal.Round(arts[i].price??0, 2) %></b></p>
                                </div>
                                <div class="col-sm-4">
                                    <p class="pull-right"><b><%= arts[i].quantity %></b> left</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <%
                if ((i + 1) % 3 == 0)
                {
            %>
        </div>
        <%
                    }
                }
            }
        %>
    </div>

    </div>
</asp:Content>
