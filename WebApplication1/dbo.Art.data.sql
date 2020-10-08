﻿CREATE TABLE [dbo].[Pages] (
    [Id]          INT            NOT NULL,
    [title]       NVARCHAR (50)  NULL,
    [description] NVARCHAR (100) NULL,
    [file_name]   NVARCHAR (100) NULL,
    [parent_id]   INT            NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UC_FILENAME] UNIQUE NONCLUSTERED ([file_name] ASC)
);



INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (0, N'Add New Art', N'Add new art to sales', N'~/pages/AddArt.aspx', -1)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (1, N'My Art Work', N'View My Sales', N'~/pages/ArtWorkSales.aspx', -1)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (2, N'Bank database', N'Bank Databse', N'~/pages/BankAccountConfigure.aspx', 15)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (3, N'Credit Card Database', N'Card Database', N'~/pages/CardConfigure.aspx', 15)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (4, N'Change Password', N'Change My Password', N'~/pages/ChangePassword.aspx', 14)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (5, N'Login', N'Login Now', N'~/pages/Login.aspx', -1)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (6, N'Account Details', N'User Account', N'~/pages/MyAccount.aspx', 14)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (7, N'My Cart', N'My Cart', N'~/pages/MyCart.aspx', 14)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (8, N'My Gallery', N'My Gallery', N'~/pages/MyGallery.aspx', 14)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (9, N'My Order', N'My Order', N'~/pages/MyOrder.aspx', 14)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (10, N'My Wish Lis', N'My Wish List', N'~/pages/MyWishList.aspx', 14)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (11, N'PalPal DataBase', N'PalPal Database', N'~/pages/PayPalAccountConfigure.aspx', 15)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (12, N'Sign Up', N'Sign Up', N'~/pages/Register.aspx', -1)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (13, N'Shop', N'Shop', N'~/pages/Shop.aspx', -1)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (14, N'My Account', N'My Account', N'MyAccount', -1)
INSERT INTO [dbo].[Pages] ([Id], [title], [description], [file_name], [parent_id]) VALUES (15, N'External Database', N'Database of other compny', N'DatabaseCompany', -1)
