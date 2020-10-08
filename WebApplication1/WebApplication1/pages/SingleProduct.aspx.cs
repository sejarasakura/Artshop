using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.model;

namespace WebApplication1.pages
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        public static Art art = null;
        public static User artist = null;
        public static DateTime dt = new DateTime();
        protected void Page_Load(object sender, EventArgs e)
        {
            init_data();
            if (art != null)
                rangeValidator.MaximumValue = art.quantity + "";
            else
            {
                init_data();
                if (art != null)
                    rangeValidator.MaximumValue = art.quantity + "";
            }
        }

        protected void MyBtnHandler(Object sender, EventArgs e)
        {
            addCart(art.art_id);
            // Add cart
        }
        protected void MyBtnHandler2(Object sender, EventArgs e)
        {
            addWish(art.art_id);
            // Add cart
        }
        protected void init_data()
        {
            try
            {
                int id = Int32.Parse(Request["id"]);
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    art = db.Arts.Find(id);
                    artist = db.Users.Find(art.artist_id);
                    dt = art.date_done ?? DateTime.Now;
                }
            }
            catch { }
        }
        private void addCart(int art_id)
        {
            User cust = null;
            if (cust == null)
                cust = WebApplication1.master.Site1.GetLogin(Response);
            if (cust == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
            Cart cart = new Cart();
            try
            {
                int id = Int32.Parse(Request["id"]);
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    art = db.Arts.Find(id);
                    cart.user_id = cust.user_id;
                    cart.art_id = art.art_id;
                    cart.quantity = Int32.Parse(input_number.Text);

                    // find user has add cart or not
                    var added_cart = db.Carts.SqlQuery(
                        "Select * From Cart Where user_id = @user_id AND art_id = @art_id AND relation = @relation",
                        new SqlParameter("@user_id", cart.user_id),
                        new SqlParameter("@relation", (char)Relation.Cart),
                        new SqlParameter("@art_id", cart.art_id)
                        ).ToArray();

                    if (added_cart.Length > 0)
                    {
                        //update
                        Cart old_cart = db.Carts.Find(added_cart[0].cart_id);
                        old_cart.quantity += cart.quantity;
                        db.Carts.AddOrUpdate(old_cart);
                        db.SaveChanges();
                        preview.InnerHtml =
                          "<div class=\"alert alert-success alert-dismissible\">" +
                            "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                            "<strong>Successful increase cart value!</strong> [" + art.name + "] * " + old_cart.quantity + " product is added to cart" + " has done registration !!" +
                          "</div>";
                    }
                    else
                    {
                        cart.relation = Convert.ToString((char)Relation.Cart);
                        this.real_add_wishList(db, cart);
                        preview.InnerHtml =
                          "<div class=\"alert alert-success alert-dismissible\">" +
                            "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                            "<strong>Successful added to cart!</strong> [" + art.name + "] * " + cart.quantity + " product is added to cart" + " has done registration !!" +
                          "</div>";
                    }
                }

            }
            catch (Exception x)
            {
                preview.InnerHtml =
                  "<div class=\"alert alert-danger alert-dismissible\">" +
                    "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                    "<strong>Add to cart Fail!</strong> the product not added please try agian. " + x.Message +
                  "</div>";
            }
        }
        private void addWish(int art_id)
        {
            User cust = null;
            if (cust == null)
                cust = WebApplication1.master.Site1.GetLogin(Response);
            if (cust == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
            Cart cart = new Cart();
            try
            {
                int id = Int32.Parse(Request["id"]);
                using (ArtGalleryV2Entities db = new ArtGalleryV2Entities())
                {
                    art = db.Arts.Find(id);
                    cart.user_id = cust.user_id;
                    cart.art_id = art.art_id;
                    cart.quantity = 1;
                    cart.relation = Convert.ToString((char)Relation.WishList);
                    // find user has add cart or not
                    var added_cart = db.Carts.SqlQuery(
                        "Select * From Cart Where user_id = @user_id AND art_id = @art_id AND relation = @relation",
                        new SqlParameter("@user_id", cart.user_id),
                        new SqlParameter("@relation", (char)Relation.WishList),
                        new SqlParameter("@art_id", cart.art_id)
                        ).ToArray();

                    if (added_cart.Length > 0)
                    {
                        preview.InnerHtml =
                            "<div class=\"alert alert-success alert-dismissible\">" +
                            "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                            "<strong>You had added to wish list!</strong> [" + art.name + "] product is added to wish list" +
                            "</div>";
                    }
                    else
                    {
                        this.real_add_wishList(db, cart);
                        preview.InnerHtml =
                          "<div class=\"alert alert-success alert-dismissible\">" +
                            "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                            "<strong>Successful added to your wish list!</strong> [" + art.name + "] product is added to wish list" +
                          "</div>";
                    }
                }

            }
            catch (Exception x)
            {
                preview.InnerHtml =
                  "<div class=\"alert alert-danger alert-dismissible\">" +
                    "<a href = \"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                    "<strong>Add to wish list Fail!</strong> the product not added please try agian. " + x.Message +
                  "</div>";
            }
        }

        private void real_add_wishList(ArtGalleryV2Entities db, Cart cart)
        {
            List<Cart> num_cart = db.Carts.ToList<Cart>();
            int count = num_cart.Count;
            if (count > 0)
            {
                Cart c = db.Carts.Find(num_cart.Last().cart_id);
                cart.cart_id = (c.cart_id + 1);
            }
            db.Carts.Add(cart);
            db.SaveChanges();
        }
    }
}