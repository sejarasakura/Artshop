<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true"
    CodeBehind="SingleProduct.aspx.cs" Inherits="WebApplication1.pages.WebForm5" %>

<%@ Import Namespace="WebApplication1.model" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        if(art == null)
        init_data();
    %>
    <div class="container">
        <br />
        <h1 style="font-size: 40pt;"><%= art==null?"No Product Found!!":art.name %></h1>
        <br />
        <div id="preview" runat="server"></div>
        <%if (art == null)
            { %>
        <div class="alert alert-danger alert-dismissible">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <strong>The art product you found is deleted !!</strong>
            <a href="Shop.aspx">continew to shop</a>
        </div>
        <%
            }
            else
            {%>

        <div class="row">
            <div class="col-sm-6">
                <img
                    style="border: 3px double;"
                    class="pull-left"
                    src="<%= "https://" + HttpContext.Current.Request.Url.Authority %>/Class/ArtPicGetter.ashx?id=<%=art.art_id%>"
                    alt="<%= art.name%>"
                    width="100%"
                    height="auto">
            </div>
            <div class="col-sm-6" style="margin-top: 20px;">
                <div class="row">
                    <div class="col-sm-12">
                        <h3 style="margin-top: 0px;">Artist:</h3>
                        <h4 style="margin-top: 0px; padding-left: 50px;"><%= artist.first_name +" "+ artist.last_name%></h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <h3 style="">Completed By:</h3>
                        <h4 style="margin-top: 0px; padding-left: 50px;"><%= dt.ToString("dddd, dd MMMM yyyy")%></h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <h3 style="">Discription:</h3>
                        <h4 style="margin-top: 0px; padding-left: 50px;"><%= art.description%></h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <h3 style="">Price:</h3>
                        <h4 style="margin-top: 0px; padding-left: 50px;">RM <%= Decimal.Round(art.price??0, 2)%></h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <h3 style="">Stock:</h3>
                        <h4 style="margin-top: 0px; padding-left: 50px;"><%= art.quantity%> remain</h4>
                    </div>
                </div>
                <div class="form-group" style="margin-top:20px;font-size:22px">
                    <div class="row">
                        <div class="col-sm-6">
                            <asp:TextBox
                                ID="input_number"
                                runat="server"
                                TextMode="Number"
                                CssClass="form-control"
                                text="1"
                                min="1"
                                max="<%# art.quantity%>"/>
                            <asp:RequiredFieldValidator
                                ID="val1"
                                runat="server"
                                SetFocusOnError="true"
                                Display="Dynamic"
                                ControlToValidate="input_number"
                                ErrorMessage="Number Required"
                                ForeColor="Red" />
                            <asp:RangeValidator
                                ID="rangeValidator"
                                runat="server"
                                ErrorMessage="Out Of Stock"
                                SetFocusOnError="true"
                                ControlToValidate="input_number"
                                Display="Dynamic"
                                ForeColor="red"
                                Type="Integer"
                                MinimumValue="1"
                                MaximumValue='2'/>
                        </div>
                        <div class="col-sm-6">
                            <asp:Button
                                CssClass="btn btn-success form-control"
                                Text="Add to cart"
                                ID="test"
                                runat="server"
                                OnClick="MyBtnHandler" />
                        </div>
                    </div>
                </div>
                <div class="form-group" style="margin-top:20px;font-size:22px">
                    <div class="row">
                        <div class="col-sm-12">
                            <asp:Button
                                CssClass="btn btn-success form-control"
                                Style="background-color: #ff0081;"
                                Text="&hearts; Add to my wish list"
                                ID="wish_list"
                                runat="server"
                                OnClick="MyBtnHandler2" />
                        </div>
                    </div>
                </div>
                </div>
            </div>
        <%} %>
        <br />
    </div>
</asp:Content>
