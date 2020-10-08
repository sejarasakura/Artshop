<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="MyGallery.aspx.cs" Inherits="WebApplication1.pages.MyGallery" %>

<%@ Import Namespace="WebApplication1.model" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <style>
        .container-x {
            width: 100%;
            overflow-x: scroll;
            white-space: nowrap;
            background-color: #fff;
        }

        .data-container {
            display: inline-block;
            margin-right: 20px;
            margin-bottom: 0px;
            height: 100%;
            overflow: hidden;
        }

        .control-body {
            max-height: 100%;
        }

        .img-control {
            width: auto;
            height: 300px;
        }

        .extra-margin {
            margin: 10px 20px;
        }

        .discripion-size {
            width: 270px;
            height: 80px;
            white-space: pre-wrap;
            word-wrap: break-word;
        }

        .discripion {
            overflow: hidden;
        }
    </style>
    <div class="container">

        <%
            inti_data();
        %>
        <h2>My Gallery</h2>
        <%if (ur == WebApplication1.model.UserRole.Artist)
            { %>
        <p>Need add more collection ? Go to <a href="AddArt.aspx">Shop Now</a></p>
        <%}
            else
            { %>
        <p>Need add more collection ? Go to <a href="Shop.aspx">Shop Now</a></p>
        <%}
        %>
        <br>
        <div id="preview" runat="server"></div>
        <br>
        <div class="container-x" id="flavoursContainer">

            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                    <!-- START -->
                    <div class="panel panel-default data-container">
                        <div class="panel-heading"><%# Eval("name") %></div>
                        <div class="panel-body control-body">
                            <img class="img-control" src="../Class/ArtPicGetter.ashx?id=<%# Eval("art_id") %>" alt="<%# Eval("name") %>">
                            <div class="row" style="padding-top: 10px;">
                                <div class="col-sm-8">
                                    <div class="discripion overflow-hidden">
                                        <p class="discripion-size"><%# Eval("description")%></p>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <asp:LinkButton
                                        CssClass="btn btn-success btn-blocks form-control"
                                        ID="lnkDownload"
                                        runat="server"
                                        Text="Download"
                                        OnClick="DownloadFile"
                                        CommandArgument='<%# Eval("art_id")%>' />
                                    <a
                                        href="ImageViewer.aspx?id=<%# Eval("art_id") %>&name=<%# Eval("name") %>"
                                        target="_blank"
                                        class="btn btn-default btn-block form-control"
                                        style="margin-top: 10px">View Image
                                    </a>
                                </div>
                                <br />
                            </div>
                            <div class="row" style="padding-top: 0">
                                <div class="col-sm-12 text-center">
                                    <a href="SingleProduct.aspx?id=<%# Eval("art_id")%>">View Details
                                    </a>
                                </div>
                                <br />
                            </div>
                        </div>
                    </div>
                    <!-- END -->
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>
    <script>
        const flavoursContainer = document.getElementById("flavoursContainer")
        const flavoursScrollWidth = flavoursContainer.scrollWidth

        window.addEventListener("load", () => {
            self.setInterval(() => {
                if (flavoursContainer.scrollLeft < (flavoursContainer.scrollWidth - flavoursContainer.offsetWidth)) {
                    flavoursContainer.scrollTo(flavoursContainer.scrollLeft + 1, 0);
                }
                else { flavoursContainer.scrollLeft = 0; }
            }, 15);
        })

    </script>

</asp:Content>
