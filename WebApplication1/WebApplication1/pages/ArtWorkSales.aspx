<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="ArtWorkSales.aspx.cs" Inherits="WebApplication1.pages.ArtWorkSales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <% LoadUser(); %>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <h2>My Art Work</h2>
            <p>Add more artwork now ? <a href="AddArt.aspx">Add new art</a></p>
            <br>
            <div id="preview" runat="server"></div>
            <br>

            <asp:GridView
                CssClass="table table-hover"
                ID="GridView1"
                runat="server"
                AllowPaging="True"
                AutoGenerateColumns="False"
                CellPadding="4"
                DataSourceID="SqlDataSource1"
                ForeColor="#333333"
                GridLines="None"
                SelectedRowStyle-BackColor="#888888"
                OnRowCommand="GridView1_RowCommand"
                OnPageIndexChanging="GridView1_PageIndexChanging"
                OnRowCancelingEdit="GridView1_RowCancelingEdit"
                OnRowEditing="GridView1_RowEditing"
                OnRowUpdating="GridView1_RowUpdating">
                <Columns>
                    <asp:BoundField
                        DataField="art_id"
                        HeaderText="Art ID"
                        SortExpression="art_id"
                        ReadOnly="True" />
                    <asp:TemplateField
                        HeaderText="Art Peview">
                        <ItemTemplate>
                            <asp:Image ID="Image1"
                                Height="100"
                                Width="100"
                                runat="server"
                                ImageUrl='<%# Eval("art_id", "~/Class/ArtPicGetter.ashx?id={0}")%>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:FileUpload
                                ID="FileUpload1"
                                runat="server" />
                            // shown only in edit mode
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField
                        HeaderText="Art Name">
                        <EditItemTemplate>
                            <asp:TextBox
                                ID="TextBoxName"
                                runat="server"
                                Text='<%# Bind("name") %>'>
                            </asp:TextBox>
                            <asp:RequiredFieldValidator
                                ForeColor="Red"
                                runat="server"
                                ID="RequiredFieldValidator5"
                                ControlToValidate="TextBoxName"
                                ErrorMessage="Please enter your title!" />
                            <asp:RegularExpressionValidator
                                ForeColor="Red"
                                ID="regexEmailValid"
                                runat="server"
                                ValidationExpression="[\s\S]{10,150}$"
                                ControlToValidate="TextBoxName"
                                ErrorMessage="The description only accept max 50 word only" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label
                                ID="LabelName"
                                runat="server"
                                Text='<%# Bind("name") %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField
                        HeaderText="Description">
                        <EditItemTemplate>
                            <asp:TextBox
                                ID="TextBoxDes"
                                runat="server"
                                Text='<%# Bind("description") %>'>
                            </asp:TextBox>
                            <asp:RequiredFieldValidator
                                ForeColor="Red"
                                runat="server"
                                ID="RequiredFieldValidator4"
                                ControlToValidate="TextBoxDes"
                                ErrorMessage="Please enter your description!" />
                            <asp:RegularExpressionValidator
                                ForeColor="Red"
                                Display="Dynamic"
                                ControlToValidate="TextBoxDes"
                                ID="RegularExpressionValidator6"
                                ValidationExpression="[\s\S]{0,250}$"
                                runat="server"
                                ErrorMessage="The description only accept max 250 word only" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LabelDes" runat="server"
                                Text='<%# Bind("description") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField
                        HeaderText="Quantity">
                        <EditItemTemplate>
                            <asp:TextBox
                                ID="TextBoxQuantity"
                                runat="server"
                                Text='<%# Bind("quantity") %>'>
                            </asp:TextBox>
                            <asp:RequiredFieldValidator
                                ForeColor="Red"
                                runat="server"
                                ID="RequiredFieldValidator3"
                                ControlToValidate="TextBoxQuantity"
                                ErrorMessage="Please enter quantity!" />
                            <asp:RegularExpressionValidator
                                ForeColor="Red"
                                Display="Dynamic"
                                ControlToValidate="TextBoxQuantity"
                                ID="RegularExpressionValidator4"
                                ValidationExpression="[0-9]{0,3}$"
                                runat="server"
                                ErrorMessage="The maximum quantity is 999" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label
                                ID="LabelQuantity"
                                runat="server"
                                Text='<%# Bind("quantity") %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField
                        HeaderText="Price">
                        <EditItemTemplate>
                            <asp:TextBox
                                ID="TextBoxPrice"
                                runat="server"
                                DataFormatString="{0:F2}"
                                Text='<%# Bind("price", "{0:0.00}") %>'>
                            </asp:TextBox>
                            <asp:RequiredFieldValidator
                                ForeColor="Red"
                                runat="server"
                                ID="RequiredFieldValidator"
                                ControlToValidate="TextBoxPrice"
                                ErrorMessage="Please enter the sales price!" />
                            <asp:RegularExpressionValidator
                                ForeColor="Red"
                                Display="Dynamic"
                                ControlToValidate="TextBoxPrice"
                                ID="RegularExpressionValidator1"
                                ValidationExpression="^\d{0,8}(\.\d{1,2})?$"
                                runat="server"
                                ErrorMessage="The price too large" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label
                                ID="LabelPrice"
                                runat="server"
                                DataFormatString="{0:F2}"
                                Text='<%# Bind("price", "{0:0.00}") %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:ButtonField CommandName="Delete Row" Text="Delete" />
                    <asp:CommandField ShowEditButton="True" />
                </Columns>

                <SelectedRowStyle BackColor="#888888"></SelectedRowStyle>
            </asp:GridView>
            <asp:SqlDataSource
                ID="SqlDataSource1"
                runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString3 %>"
                SelectCommand="SELECT * FROM Art WHERE artist_id = @artist_id"
                DeleteCommand="DELETE FROM [Art] WHERE (art_id = @art_id)"
                UpdateCommand="UPDATE Art SET quantity = @quantity WHERE (art_id = @art_id)">
                <DeleteParameters>
                    <asp:Parameter Name="Art_id" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="" Name="artist_id" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="quantity" />
                    <asp:Parameter Name="art_id" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
        </div>
        <div class="col-md-1"></div>

    </div>
</asp:Content>
