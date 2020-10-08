<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="AddArt.aspx.cs" Inherits="WebApplication1.pages.AddArt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
  <h2>Add Art</h2>
  <p>Salse your product online start form now</p>
    <br>
                <div id="preview" runat="server"></div>  
    <br>

     <!--Title-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
              <label for="usr">Title:</label>
                <asp:textbox 
                    CssClass="form-control" 
                    id="TitleText" 
                    placeholder = "Please title" 
                    text = "" 
                    runat="server" /> 
                  <asp:RequiredFieldValidator 
                      CssClass="alert alert-danger"
                      runat="server" 
                      id="RequiredFieldValidator5" 
                      controltovalidate="TitleText" 
                      errormessage="Please enter your title!" />
                    <asp:RegularExpressionValidator 
                        CssClass="alert alert-danger" 
                        ID="regexEmailValid" 
                        runat="server" 
                        ValidationExpression="[\s\S]{10,150}$" 
                        ControlToValidate="TitleText" 
                        ErrorMessage="The description only accept max 50 word only" />
            </div>
        </div>
    </div>

     <!--Discription-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
              <label for="usr">Discription:</label>
                <asp:textbox 
                    CssClass="form-control" 
                    id="Discription" 
                    placeholder = "Please enter description" 
                    text = "" 
                    rows= "4" 
                    mode= "multiline" 
                    runat="server" /> 
                  <asp:RequiredFieldValidator 
                      CssClass="alert alert-danger"
                      runat="server" 
                      id="RequiredFieldValidator4" 
                      controltovalidate="Discription" 
                      errormessage="Please enter your description!" />
                    <asp:RegularExpressionValidator 
                        CssClass="alert alert-danger"
                        Display = "Dynamic" 
                        ControlToValidate = "Discription" 
                        ID="RegularExpressionValidator6" 
                        ValidationExpression = "[\s\S]{0,250}$" 
                        runat="server" 
                        ErrorMessage="The description only accept max 250 word only" />
            </div>
        </div>
    </div>
        
     <!--Quantity-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
              <label for="usr">Quantity :</label>
                <asp:textbox 
                    CssClass="form-control" 
                    id="Quantity" 
                    placeholder = "please enter the quantity" 
                    type ="number" 
                    runat="server" /> 
                  <asp:RequiredFieldValidator 
                      CssClass="alert alert-danger"
                      runat="server" 
                      id="RequiredFieldValidator3" 
                      controltovalidate="Quantity" 
                      errormessage="Please enter quantity!" />
                    <asp:RegularExpressionValidator 
                        CssClass="alert alert-danger"
                        Display = "Dynamic" 
                        ControlToValidate = "Quantity" 
                        ID="RegularExpressionValidator4" 
                        ValidationExpression = "[0-9]{0,3}$" 
                        runat="server" 
                        ErrorMessage="The maximum quantity is 999" />
            </div>
        </div>
    </div>

     <!--Price-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
              <label for="usr">Price :</label>
                <asp:textbox 
                    CssClass="form-control" 
                    id="Price" 
                    placeholder = "eg 99.9 or 99.99" 
                    text = "" 
                    runat="server" /> 
                  <asp:RequiredFieldValidator 
                      CssClass="alert alert-danger"
                      runat="server" 
                      id="RequiredFieldValidator" 
                      controltovalidate="Price" 
                      errormessage="Please enter the sales price!" />
                    <asp:RegularExpressionValidator 
                        CssClass="alert alert-danger"
                        Display = "Dynamic" 
                        ControlToValidate = "Price" 
                        ID="RegularExpressionValidator1" 
                        ValidationExpression = "^\d{0,8}(\.\d{1,2})?$" 
                        runat="server" 
                        ErrorMessage="The price too large" />
            </div>
        </div>
    </div>

     <!--Date Creation-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
              <label for="pwd">Date creation:</label>
                <asp:textbox 
                    type="date" 
                    CssClass="form-control" 
                    id="DateCreation" 
                    placeholder = "Please Enter date creation" 
                    runat="server" /> 
                  <asp:RequiredFieldValidator 
                      CssClass="alert alert-danger"
                      runat="server" 
                      id="RequiredFieldValidator6" 
                      controltovalidate="DateCreation" 
                      errormessage="Please enter date of creation!" />
            </div>
        </div>
    </div>

     <!--Load Picture-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
              <label for="pwd">Upload Image:</label>
                <asp:FileUpload  
                    type="file" 
                    name="file" 
                    onchange="previewFile()" 
                    CssClass="form-control" 
                    id="FileUpload" 
                    placeholder = "Upload your profile picture" 
                    runat="server" />
            </div>
        </div>
    </div>
        
    <script type="text/javascript">
        function previewFile() {
            var preview = document.querySelector('#<%=Image1.ClientID %>');
            var file = document.querySelector('#<%=FileUpload.ClientID %>').files[0];
            var reader = new FileReader();

            reader.onloadend = function () {
                preview.src = reader.result;
            }

            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.src = "";
            }
        }
    </script>
        
     <!--Load Picture-->
    <div class="row">
        <div class="col-md-4">
                <asp:Image CssClass="center" ImageUrl="~/Class/ArtPicGetter.ashx?id=-1" ID="Image1" runat="server" length="100px" Width="100px" />  
                <br />  
        </div>
        <div class="col-md-4">
        </div>
    </div>
        
    <br>
    <br>
        <asp:Button 
            Class="btn btn-success pull-right" 
            ID="submitButton" 
            runat="server" 
            Text="Publish Art" 
            OnClick="submitButton_Click" />
         <a href="#" style="margin-right: 20px;" class="btn btn-default">To Login Page</a>
</div>
</asp:Content>
