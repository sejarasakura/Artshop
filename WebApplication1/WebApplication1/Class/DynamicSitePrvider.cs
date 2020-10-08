using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Xml;
using System.Security.Permissions;
using System.Collections.Generic;
using WebApplication1.model;

/// <summary>
/// Summary description for DynamicSiteMapProvider
/// Creates a dynamic SiteMapProvider
/// Dynamically creates the Web.sitemap xml file
/// </summary>
public class DynamicSiteMapProvider : StaticSiteMapProvider
{

    private const string ExcludedFolders = "(App_Data)|(obj)|(Scripts)|(App_Code)|(bin)|(fonts)|(Content)";
    private const string ExcludedFiles = "(Default.aspx)";
    private const string ExcludedFilesByExtension = "(.cs)|(.exclude)|(.config)|(.master)|(master.cs)|(.rdlc)|(.ico)|(.ascx)|(.asax)|(.webinfo)|(.sitemap)";
    private const string PAGE_DIR = "~/pages/";

    private SiteMapNode parentNode = null;
    public SiteMapNode ParentNode
    {
        get { return parentNode; }
        set { parentNode = value; }
    }
    protected override SiteMapNode GetRootNodeCore()
    {
        return BuildSiteMap();
    }
    public override SiteMapNode BuildSiteMap()
    {
        lock (this)
        {
            parentNode = HttpContext.Current.Cache["SiteMap"] as SiteMapNode;
            if (parentNode == null)
            {
                base.Clear();
                parentNode = new SiteMapNode(this,
                    HttpRuntime.AppDomainAppVirtualPath,
                    "Home");

                AddAllCustomNode();
                HttpContext.Current.Cache.Insert("SiteMap", parentNode);
            }
            return parentNode;
        }
    }
    public void AddAllCustomNode()
    {
        AddPageNode();
        AddProductNode();
        AddPaymentNode();
    }
    public void AddPageNode()
    {
        string sql = "SELECT Pages.parent_id FROM [Pages] Group By Pages.parent_id Order By Pages.parent_id";
        string sql2 = "SELECT [Pages].Id  FROM [Pages] WHERE [Pages].parent_id = -1";
        List<int> parent_id, id = new List<int>();
        Page page;
        List<Page> pages;
        SiteMapNode siteMapNode, detailsNode;
        using (WebApplication1.model.ArtGalleryV2Entities db = new WebApplication1.model.ArtGalleryV2Entities())
        {
            parent_id = db.Database.SqlQuery<int>(sql).ToList();
            id = db.Database.SqlQuery<int>(sql2).ToList();
            foreach (int x in id)
            {
                page = db.Pages.Find(x);
                pages = db.Pages.SqlQuery("SELECT * FROM [Pages] WHERE [Pages].parent_id = " + x).ToList();
                siteMapNode = new SiteMapNode(this, x+"key1", page.file_name, page.title, page.description);
                AddNode(siteMapNode, parentNode);
                if(pages.Count > 0)
                {
                    foreach(Page page1 in pages)
                    {
                        detailsNode = new SiteMapNode(this, page1.Id + "key2", page1.file_name, page1.title, page1.description);
                        AddNode(detailsNode, siteMapNode);
                    }
                }
            }
        }
    }
    public void AddProductNode()
    {
        SiteMapNode siteMapNode = new SiteMapNode(this, "Haha-2", "Product Node", "Product", "The Art Sales.com sell");
        AddNode(siteMapNode, parentNode);
        List<Art> arts;
        using (WebApplication1.model.ArtGalleryV2Entities db = new WebApplication1.model.ArtGalleryV2Entities())
        {
            arts = db.Arts.SqlQuery("SELECT * FROM [Art]").ToList();
            foreach(Art art in arts)
                AddNode(
                    new SiteMapNode(this,
                    art.art_id + "key3", 
                    PAGE_DIR + "SingleProduct.aspx?id=" +
                    art.art_id,
                    art.name,
                    art.name), 
                    siteMapNode);
        }
    }
    public void AddPaymentNode()
    {
        SiteMapNode siteMapNode = new SiteMapNode(this, "Haha-1", "Payment Node", "Payment", "Procide payment");
        AddNode(siteMapNode, parentNode);
        List<Order> orders;
        using (WebApplication1.model.ArtGalleryV2Entities db = new WebApplication1.model.ArtGalleryV2Entities())
        {
            orders = db.Orders.SqlQuery("SELECT * FROM [Order]").ToList();
            foreach (Order order in orders)
                AddNode(
                    new SiteMapNode(this, order.order_id + "key4", PAGE_DIR + "Payment.aspx?order=" + order.order_id, String.Format("#{0:D10}", order.order_id), String.Format("#{0:D10}", order.order_id)),
                    siteMapNode);
        }
    }
    public void RebuildSiteMap()
    {
        lock (this)
        {
            HttpContext.Current.Cache.Remove("SiteMap");
        }
        BuildSiteMap();
    }
    public void GenerateWebDotSiteMapXMLFile(string sFileName = "Web.sitemap")
    {
        SiteMapNodeCollection myCollection;
        if (ParentNode == null)
        {
            ParentNode = GetRootNodeCore();
        }
        myCollection = ParentNode.ChildNodes;

        //Create the Web.sitemap XML file
        Encoding enc = Encoding.UTF8;
        XmlTextWriter myXmlTextWriter = new XmlTextWriter(HttpRuntime.AppDomainAppPath + sFileName, enc);

        myXmlTextWriter.WriteStartDocument();//xml document open
        // Create the Top level (Parent element)
        myXmlTextWriter.WriteStartElement("siteMap");
        myXmlTextWriter.WriteAttributeString("xmlns", "http://schemas.microsoft.com/AspNet/SiteMap-File-1.0");

        // Create the first Node of the Menu
        myXmlTextWriter.WriteStartElement("siteMapNode");

        //Title attribute set
        myXmlTextWriter.WriteAttributeString("title", "Art Works.com");
        myXmlTextWriter.WriteAttributeString("description", "This is home");//Description attribute set
        myXmlTextWriter.WriteAttributeString("url", "~/pages/Home.aspx");//URL attribute set
        //Loop and create the main Menu nodes that are represented by folders that were included
        foreach (SiteMapNode node in ParentNode.ChildNodes)
        {
            myXmlTextWriter.WriteStartElement("siteMapNode");
            myXmlTextWriter.WriteAttributeString("title", node.Title);
            myXmlTextWriter.WriteAttributeString("description", node.Description);
            myXmlTextWriter.WriteAttributeString("url", node.Url);
            //Loop and create child nodes for the Main Menu nodes
            foreach (SiteMapNode childNode in node.ChildNodes)
            {
                myXmlTextWriter.WriteStartElement("siteMapNode");
                myXmlTextWriter.WriteAttributeString("title", childNode.Title);
                myXmlTextWriter.WriteAttributeString("description", childNode.Description);
                myXmlTextWriter.WriteAttributeString("url", childNode.Url);
                myXmlTextWriter.WriteEndElement();//Close the first siteMapNode
            }
            myXmlTextWriter.WriteEndElement();//Close the siteMapNode
        }
        myXmlTextWriter.WriteEndDocument();//xml document closed

        // clean up and release xml resources
        myXmlTextWriter.Flush();
        myXmlTextWriter.Close();
        return;
    }
}
