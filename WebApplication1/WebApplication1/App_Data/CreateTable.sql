CREATE TABLE [dbo].[Art]
(
    [art_id] INT NOT NULL PRIMARY KEY,
    [artist_id] INT NOT NULL,
    [image] IMAGE NULL,
    [quantity] INT NULL,
    [price] MONEY NULL,
    [date_done] DATE NULL
);

CREATE TABLE [dbo].[BitArt]
(
    [bit_art_id] INT NOT NULL PRIMARY KEY,
    [art_id] INT NOT NULL,
    [customer_id] INT NOT NULL,
    [quantity] INT NULL,
    [price] NCHAR(300) NULL,
    [payment_id] INT NOT NULL
);

CREATE TABLE [dbo].[Cart]
(
    [cart_id] INT NOT NULL PRIMARY KEY,
    [customer_id] INT NOT NULL,
    [is_wishlist] BIT NULL,
    [quantity] INT NULL,
    [art_id] INT NOT NULL
);

CREATE TABLE [dbo].[User]
(
    [user_id] INT NOT NULL PRIMARY KEY,
    [user_email] NCHAR(30) NOT NULL,
    [username] NCHAR(20) NULL,
    [last_name] NCHAR(20) NULL,
    [first_name] NCHAR(20) NULL,
    [user_role] NCHAR(1) NULL,
    [phone_num] NCHAR(11) NULL,
    [gender] NCHAR(1) NULL,
    [picture] IMAGE NULL,
    [password] NCHAR(50) NOT NULL
);

CREATE TABLE [dbo].[OrderDetails]
(
    [order_id] INT NOT NULL,
    [art_id] INT NOT NULL,
    [product_quantity] INT NULL
);

CREATE TABLE [dbo].[Order]
(
    [order_id] INT NOT NULL PRIMARY KEY,
    [customer_id] INT NOT NULL,
    [order_date] DATE NULL
);

CREATE TABLE [dbo].[Payment]
(
    [payment_id] INT NOT NULL PRIMARY KEY,
    [order_id] INT NOT NULL,
    [payment_method_id] INT NOT NULL,
    [tax_charge] MONEY NULL,
    [order_date] DATE NULL
);


CREATE TABLE [dbo].[PaymentMethod]
(
    [payment_method_id] INT NOT NULL PRIMARY KEY,
    [user_id] INT NOT NULL,
    [payment_role_id] INT NOT NULL,
    [payment_role] NCHAR(1) NULL
);

CREATE TABLE [dbo].[PM_Card]
(
    [payment_role_id] INT NOT NULL PRIMARY KEY,
    [card_number] NCHAR(16) NULL
);

CREATE TABLE [dbo].[PM_BankTranfer]
(
    [payment_role_id] INT NOT NULL PRIMARY KEY,
    [bank_account] NCHAR(10) NULL
);

CREATE TABLE [dbo].[PM_PayPal]
(
    [payment_role_id] INT NOT NULL PRIMARY KEY,
    [paypal_id] NCHAR(10) NULL
);

CREATE TABLE [dbo].[Card]
(
    [card_number] NCHAR(16) NOT NULL PRIMARY KEY,
    [name] NCHAR(20) NULL,
    [ccv] NCHAR(3) NULL,
    [exp_date] DATE NULL,
    [amount] MONEY NULL,
    [password] NCHAR(20) NULL,
);

CREATE TABLE [dbo].[BankTranfer]
(
    [bank_account] NCHAR(10) NOT NULL PRIMARY KEY,
    [name] NCHAR(20) NULL,
    [bank_username] NCHAR(20) NULL,
    [amount] MONEY NULL,
    [password] NCHAR(20) NULL,
);

CREATE TABLE [dbo].[PayPal]
(
    [paypal_id] NCHAR(19) NOT NULL PRIMARY KEY,
    [email] NCHAR(30) NULL,
    [name] NCHAR(20) NULL,
    [amount] MONEY NULL,
    [password] NCHAR(20) NULL
);