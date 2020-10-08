<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Sitemap.ascx.cs" Inherits="WebApplication1.Class.SitemapProduct" %>

    <div style="padding-top: 10px;padding-left:50px;">
        <asp:SiteMapPath SiteMapProvider="MasterProvider" ID="SiteMapPath1" runat="server" />
        <asp:SiteMapDataSource SiteMapProvider="MasterProvider" ID="SiteMapDataSource1" runat="server" />
    </div>
