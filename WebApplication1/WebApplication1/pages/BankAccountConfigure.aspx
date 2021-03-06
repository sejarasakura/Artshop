﻿<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site1.Master" AutoEventWireup="true" CodeBehind="BankAccountConfigure.aspx.cs" Inherits="WebApplication1.pages.BankAccountConfigure" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-1">
        </div>
        <div class="col-sm-10">
            <h2>Bank account configuration</h2>
            <br />
            <div id="preview" runat="server"></div>
            <br />
            <asp:GridView
                CssClass="table table-hover"
                ID="GridView1"
                runat="server"
                CellPadding="4"
                ForeColor="#333333"
                GridLines="None"
                SelectedRowStyle-BackColor="#888888"
                AutoGenerateColumns="False"
                AutoGenerateDeleteButton="True"
                AutoGenerateEditButton="True"
                DataKeyNames="bank_account"
                DataSourceID="SqlDataSource1" ShowFooter="True">
                <Columns>

                    <%--Bank Account No--%>
                    <asp:TemplateField HeaderText="Bank Account Number" SortExpression="bank_account">
                        <EditItemTemplate>
                            <asp:Label ID="Label112" runat="server" Text='<%# Eval("bank_account") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label312" runat="server" Text='<%# Bind("bank_account") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:LinkButton ValidationGroup="INSERT" ID="lbInsert" runat="server" OnClick="lbInsert_Click">
                                Insert
                            </asp:LinkButton>
                        </FooterTemplate>
                    </asp:TemplateField>
                    
                    <%--Username--%>
                    <asp:TemplateField HeaderText="Username" SortExpression="bank_username">
                        <EditItemTemplate>
                            <asp:Label ID="Label212" runat="server" Text='<%# Eval("bank_username") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label412" runat="server" Text='<%# Bind("bank_username") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox CssClass="form-control" ID="TextBoxUserName" runat="server" Text="">

                            </asp:TextBox>
                            <asp:RequiredFieldValidator
                                ValidationGroup="INSERT"
                                ForeColor="Red"
                                runat="server"
                                ID="RequiredFieldValidator5"
                                ControlToValidate="TextBoxUserName"
                                ErrorMessage="Please enter your username!" />
                            <asp:RegularExpressionValidator
                                ValidationGroup="INSERT"
                                ForeColor="Red"
                                Display="Dynamic"
                                ControlToValidate="TextBoxUserName"
                                ID="RegularExpressionValidator6"
                                ValidationExpression="[a-zA-Z]{0,20}$"
                                runat="server"
                                ErrorMessage="The username only accept max 20 word and must be character only" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    
                    <%--Name--%>
                    <asp:TemplateField HeaderText="Full Name in IC" SortExpression="name">
                        <EditItemTemplate>
                            <asp:TextBox
                                CssClass="form-control"
                                ID="TextBox1"
                                runat="server"
                                Text='<%# Bind("name") %>'>
                            </asp:TextBox>
                            <asp:RequiredFieldValidator
                                ValidationGroup="UPDATE"
                                ForeColor="Red"
                                runat="server"
                                ID="RequiredFieldValidator3"
                                ControlToValidate="TextBox1"
                                ErrorMessage="Please enter your full name!" />
                            <asp:RegularExpressionValidator
                                ValidationGroup="UPDATE"
                                ForeColor="Red"
                                Display="Dynamic"
                                ControlToValidate="TextBox1"
                                ID="RegularExpressionValidator4"
                                ValidationExpression="[a-zA-Z ]{0,20}$"
                                runat="server"
                                ErrorMessage="The full name only accept max 20 word and must be character only" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label398" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox CssClass="form-control" ID="TextBoxFullName" runat="server" Text="">

                            </asp:TextBox>
                            <asp:RequiredFieldValidator
                                ValidationGroup="INSERT"
                                ForeColor="Red"
                                runat="server"
                                ID="RequiredFieldValidator31"
                                ControlToValidate="TextBoxFullName"
                                ErrorMessage="Please enter your full name!" />
                            <asp:RegularExpressionValidator
                                ValidationGroup="INSERT"
                                ForeColor="Red"
                                Display="Dynamic"
                                ControlToValidate="TextBoxFullName"
                                ID="RegularExpressionValidator42"
                                ValidationExpression="[a-zA-Z ]{0,20}$"
                                runat="server"
                                ErrorMessage="The first name only accept max 20 word and must be character only" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    
                    <%--Amount--%>
                    <asp:TemplateField HeaderText="Balance" SortExpression="amount">
                        <EditItemTemplate>
                            <asp:TextBox
                                CssClass="form-control"
                                ID="TextBox2"
                                runat="server"
                                Text='<%# Bind("amount", "{0:0.00}") %>'>
                            </asp:TextBox>
                            <asp:RequiredFieldValidator
                                ValidationGroup="UPDATE"
                                ForeColor="Red"
                                runat="server"
                                ID="RequiredFieldValidator1"
                                ControlToValidate="TextBox2"
                                ErrorMessage="Please enter the balance!" />
                            <asp:RegularExpressionValidator
                                ValidationGroup="UPDATE"
                                ForeColor="Red"
                                Display="Dynamic"
                                ControlToValidate="TextBox2"
                                ID="RegularExpressionValidator11"
                                ValidationExpression="^\d{0,10}(\.\d{1,2})?$"
                                runat="server"
                                ErrorMessage="The balance is too large" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("amount", "{0:0.00}") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox CssClass="form-control" ID="TextBoxAmount" runat="server" Text="">

                            </asp:TextBox>
                            <asp:RequiredFieldValidator
                                ValidationGroup="INSERT"
                                ForeColor="Red"
                                runat="server"
                                ID="RequiredFieldValidator2"
                                ControlToValidate="TextBoxAmount"
                                ErrorMessage="Please enter the balance!" />
                            <asp:RegularExpressionValidator
                                ValidationGroup="INSERT"
                                ForeColor="Red"
                                Display="Dynamic"
                                ControlToValidate="TextBoxAmount"
                                ID="RegularExpressionValidator12"
                                ValidationExpression="^\d{0,10}(\.\d{1,2})?$"
                                runat="server"
                                ErrorMessage="The balance is too large" />
                        </FooterTemplate>
                    </asp:TemplateField>

                    <%--Password--%>
                    <asp:TemplateField HeaderText="Password" SortExpression="password">
                        <EditItemTemplate>
                            <asp:TextBox
                                CssClass="form-control"
                                ID="TextBox3"
                                runat="server"
                                Text='<%# Bind("password") %>'>
                            </asp:TextBox>
                            <asp:RequiredFieldValidator
                                ValidationGroup="UPDATE"
                                ForeColor="Red"
                                runat="server"
                                ID="RequiredFieldValidator61"
                                ControlToValidate="TextBox3"
                                ErrorMessage="Please enter your password!" />
                            <asp:RegularExpressionValidator
                                ValidationGroup="UPDATE"
                                ForeColor="Red"
                                Display="Dynamic"
                                ControlToValidate="TextBox3"
                                ID="RegularExpressionValidator21"
                                ValidationExpression="[a-zA-Z0-9]{8,50}$"
                                runat="server"
                                ErrorMessage="The password only accept 8 to 50 word and must be number or character" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("password") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox
                                CssClass="form-control"
                                ID="TextBoxPassword"
                                runat="server"
                                Text=""
                                TextMode="Password">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator
                                ValidationGroup="INSERT"
                                ForeColor="Red"
                                runat="server"
                                ID="RequiredFieldValidator71"
                                ControlToValidate="TextBoxPassword"
                                ErrorMessage="Please reenter the password agian!" />
                            <asp:RegularExpressionValidator
                                ValidationGroup="INSERT"
                                ForeColor="Red"
                                Display="Dynamic"
                                ControlToValidate="TextBoxPassword"
                                ID="RegularExpressionValidator32"
                                ValidationExpression="[a-zA-Z0-9]{8,50}$"
                                runat="server"
                                ErrorMessage="The password only accept 8 to 50 word and must be number or character" />
                        </FooterTemplate>
                    </asp:TemplateField>

                </Columns>
                <SelectedRowStyle BackColor="#888888"></SelectedRowStyle>
            </asp:GridView>
            <asp:SqlDataSource
                ID="SqlDataSource1"
                runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString3 %>"
                DeleteCommand="DELETE FROM [BankTranfer] WHERE [bank_account] = @bank_account"
                InsertCommand="INSERT INTO [BankTranfer] ([bank_account], [name], [bank_username], [amount], [password]) VALUES (@bank_account, @name, @bank_username, @amount, @password)"
                SelectCommand="SELECT * FROM [BankTranfer]"
                UpdateCommand="UPDATE [BankTranfer] SET [name] = @name, [amount] = @amount, [password] = @password WHERE [bank_account] = @bank_account">
                <DeleteParameters>
                    <asp:Parameter Name="bank_account" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="bank_account" Type="String" />
                    <asp:Parameter Name="name" Type="String" />
                    <asp:Parameter Name="bank_username" Type="String" />
                    <asp:Parameter Name="amount" Type="Decimal" />
                    <asp:Parameter Name="password" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="name" Type="String" />
                    <asp:Parameter Name="amount" Type="Decimal" />
                    <asp:Parameter Name="password" Type="String" />
                    <asp:Parameter Name="bank_account" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>

        </div>
        <div class="col-sm-1">
        </div>
    </div>
</asp:Content>
