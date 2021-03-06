USE [master]
GO
/****** Object:  Database [YENSAO]    Script Date: 12/8/2021 10:22:56 PM ******/
CREATE DATABASE [YENSAO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'YENSAO', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\YENSAO.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'YENSAO_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\YENSAO_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [YENSAO] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [YENSAO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [YENSAO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [YENSAO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [YENSAO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [YENSAO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [YENSAO] SET ARITHABORT OFF 
GO
ALTER DATABASE [YENSAO] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [YENSAO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [YENSAO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [YENSAO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [YENSAO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [YENSAO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [YENSAO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [YENSAO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [YENSAO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [YENSAO] SET  DISABLE_BROKER 
GO
ALTER DATABASE [YENSAO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [YENSAO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [YENSAO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [YENSAO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [YENSAO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [YENSAO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [YENSAO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [YENSAO] SET RECOVERY FULL 
GO
ALTER DATABASE [YENSAO] SET  MULTI_USER 
GO
ALTER DATABASE [YENSAO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [YENSAO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [YENSAO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [YENSAO] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [YENSAO] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [YENSAO] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'YENSAO', N'ON'
GO
ALTER DATABASE [YENSAO] SET QUERY_STORE = OFF
GO
USE [YENSAO]
GO
/****** Object:  Table [dbo].[Branchs]    Script Date: 12/8/2021 10:22:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branchs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Branchs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12/8/2021 10:22:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [ntext] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 12/8/2021 10:22:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Fullname] [nvarchar](100) NULL,
	[Birthday] [datetime] NULL,
	[Address] [nvarchar](500) NULL,
	[Gender] [nvarchar](3) NULL,
	[UserId] [int] NOT NULL,
	[Phone] [nchar](10) NULL,
 CONSTRAINT [PK_Infomations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 12/8/2021 10:22:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Url] [char](200) NULL,
	[ProductId] [int] NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 12/8/2021 10:22:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Numbers] [int] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12/8/2021 10:22:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[CustomerId] [int] NOT NULL,
	[Total] [float] NULL,
	[Address] [nvarchar](200) NULL,
	[Name] [nvarchar](100) NULL,
	[NumberPhone] [nchar](10) NULL,
	[OrderStatusId] [int] NULL,
 CONSTRAINT [PK_DatHang] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 12/8/2021 10:22:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK_OrderStatus_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 12/8/2021 10:22:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](255) NULL,
	[CategoryId] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[Detail] [ntext] NULL,
	[Highlight] [bit] NULL,
	[NewProduction] [bit] NULL,
	[Sale] [float] NULL,
	[Price] [float] NULL,
	[Unit] [nvarchar](10) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[BranchId] [int] NULL,
	[Weight] [int] NULL,
	[Expiry] [int] NULL,
	[ManufacturingDate] [datetime] NULL,
	[Origin] [nvarchar](100) NULL,
	[SupplierId] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 12/8/2021 10:22:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Address] [nvarchar](200) NULL,
	[Phone] [nchar](10) NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/8/2021 10:22:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](40) NULL,
	[Password] [char](100) NULL,
	[Role] [char](10) NULL,
	[Enable] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Branchs] ON 

INSERT [dbo].[Branchs] ([Id], [Name]) VALUES (37, N'Khánh Hòa Nest')
INSERT [dbo].[Branchs] ([Id], [Name]) VALUES (34, N'Nhà Yến Bắc Kinh')
INSERT [dbo].[Branchs] ([Id], [Name]) VALUES (1, N'Nhà yến Nha Trang')
INSERT [dbo].[Branchs] ([Id], [Name]) VALUES (40, N'Thêm Thương Hiệu Test')
INSERT [dbo].[Branchs] ([Id], [Name]) VALUES (32, N'Thượng Vy Yến')
INSERT [dbo].[Branchs] ([Id], [Name]) VALUES (2, N'Tổ yến sào Khánh Văn')
INSERT [dbo].[Branchs] ([Id], [Name]) VALUES (39, N'Yến Bình Định Edited')
INSERT [dbo].[Branchs] ([Id], [Name]) VALUES (38, N'Yến Mộc')
SET IDENTITY_INSERT [dbo].[Branchs] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (1, N'Bạch yến  ', N'Bạch yến hay còn gọi là tổ yến trắng, bạch yến có màu trắng ngà, mặt tổ dày, sợi yến dày. ... Giống như các loại yến khác, bạch yến là loại tổ yến được lấy từ nước dãi của con chim yến.')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (2, N'Hồng Yến  ', N'Hồng yến chỉ có một số chú yến đảo ở những vách đá cheo leo bên ngoài đảo xa nơi hang đá dựng đứng mới tìm được. Vậy hồng yến cũng là một mẫu tổ khiến cho từ nước dãi chim yến có màu cam hay màu vàng như lòng đỏ trứng gà.')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (3, N'Huyết Yến ', N'Yến huyết hay còn gọi là yến đỏ. Đây là loại yến quý hiếm và gắn với đó có rất nhiều câu chuyện hay. Một số người cho rằng, do chúng có sự pha trộn nước bọt và máu của chim yến trong quá trình xây tổ nên được gọi là yến huyết.')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (7, N'Yến Trưng', N'Sợi yến nở to, dai, có mùi thơm đặc trưng. Quy trình sản xuất hoàn toàn bằng dây chuyền, máy móc hiện đại theo tiêu chuẩn quốc tế. Yến chưng không phụ gia, chất bảo quản, đảm bảo vệ sinh an toàn thực phẩm.')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [Fullname], [Birthday], [Address], [Gender], [UserId], [Phone]) VALUES (1, N'Ung Luân', CAST(N'2000-10-08T00:00:00.000' AS DateTime), N'Bình Phước', N'Nữ', 16, N'0123456789')
INSERT [dbo].[Customers] ([Id], [Fullname], [Birthday], [Address], [Gender], [UserId], [Phone]) VALUES (2, N'Ung Nguyễn Trường Luân', CAST(N'2000-10-24T00:00:00.000' AS DateTime), N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Nam', 17, N'0123456789')
INSERT [dbo].[Customers] ([Id], [Fullname], [Birthday], [Address], [Gender], [UserId], [Phone]) VALUES (3, N'Ung Nguyễn Trường Luân', CAST(N'2000-10-08T00:00:00.000' AS DateTime), N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Nam', 18, N'0123456789')
INSERT [dbo].[Customers] ([Id], [Fullname], [Birthday], [Address], [Gender], [UserId], [Phone]) VALUES (4, N'Ung Nguyễn Trường Luân', CAST(N'2000-10-08T00:00:00.000' AS DateTime), N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước Edited', N'Nam', 19, N'0382916020')
INSERT [dbo].[Customers] ([Id], [Fullname], [Birthday], [Address], [Gender], [UserId], [Phone]) VALUES (5, N'Ung Nguyễn Trường Luân', CAST(N'2000-10-08T00:00:00.000' AS DateTime), N'97-Man Thiện-Hiệp Phú-TP Thủ Đức-TP.HCM', N'Nam', 20, N'0382916020')
INSERT [dbo].[Customers] ([Id], [Fullname], [Birthday], [Address], [Gender], [UserId], [Phone]) VALUES (6, N'Nguyễn Văn A', CAST(N'2000-10-08T00:00:00.000' AS DateTime), N'97-Man Thiện-Hiệp Phú-TP Thủ Đức-TP.HCM', N'Nam', 21, N'0382916020')
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Images] ON 

INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (1, N'211201005030-1419f2b03dfb491860e518317ae2406c.jpg                                                                                                                                                       ', 1)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (2, N'211118230126-bk_nhatrang.jpg                                                                                                                                                                            ', 2)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (3, N'211118230126-bk_nhatrang.jpg                                                                                                                                                                            ', 3)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (9, N'211118011651-bk_nhatrang.jpg                                                                                                                                                                            ', 17)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (12, N'211119000243-to_yen_trang_tinh_che.jpg                                                                                                                                                                  ', 20)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (15, N'211119001912-yen-nhan-sam.jpg                                                                                                                                                                           ', 23)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (19, N'211119002940-yenhong1.jpg                                                                                                                                                                               ', 27)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (20, N'211119002846-yentrung.jpg                                                                                                                                                                               ', 28)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (23, N'211119003621-5fced5190adf88a2e8cd6f710c056f8b.jpg                                                                                                                                                       ', 31)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (25, N'211119003811-1419f2b03dfb491860e518317ae2406c.jpg                                                                                                                                                       ', 33)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (26, N'211119004750-yen-huyet-dao-thuong-hang-khanh-hoa-nest-100g-to-yen-sao-yen-huyet.jpg                                                                                                                     ', 34)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (27, N'211119004659-hong-yen-ngon-cao-cap-1---Copy.jpg                                                                                                                                                         ', 35)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (28, N'211119005121-yen-huyet-ngon-tinh-che-100g-2.jpg                                                                                                                                                         ', 36)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (29, N'211119005318-yentrang2.jpg                                                                                                                                                                              ', 37)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (31, N'211119005541-yenhuyet1.jpg                                                                                                                                                                              ', 39)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (32, N'211121101819-yentrung.jpg                                                                                                                                                                               ', 42)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (44, N'211206102112-Yan Yan Fang Rebranding (1).png                                                                                                                                                            ', 54)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (50, N'211206120459-78744612_166995191181688_6863792624448516857_n.jpg                                                                                                                                         ', 60)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (51, N'211208141823-ac1641a8b5-e1586919026668.jpg                                                                                                                                                              ', 61)
INSERT [dbo].[Images] ([Id], [Url], [ProductId]) VALUES (52, N'211208143656-f840dada50ef4f5df9aeac7c4bf40008.jpg                                                                                                                                                       ', 62)
SET IDENTITY_INSERT [dbo].[Images] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (1, 6, 1, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (2, 7, 2, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (3, 8, 27, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (61, 31, 1, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (62, 32, 1, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (69, 34, 27, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (70, 34, 34, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (71, 34, 28, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (72, 34, 36, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (73, 35, 2, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (74, 35, 3, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (75, 35, 27, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (77, 36, 34, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (78, 36, 36, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (79, 36, 1, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (80, 36, 20, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (81, 37, 1, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (82, 37, 17, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (83, 37, 35, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (84, 37, 34, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (85, 37, 28, 6)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (86, 38, 17, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (87, 38, 20, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (88, 39, 28, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (89, 39, 34, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (90, 39, 31, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (91, 39, 23, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (92, 40, 39, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (93, 40, 2, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (94, 40, 36, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (95, 41, 28, 12)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (96, 42, 23, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (97, 42, 34, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (98, 42, 2, 9)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (99, 42, 39, 6)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (100, 43, 28, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (101, 43, 35, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (102, 43, 34, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (103, 44, 3, 12)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (104, 44, 28, 9)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (105, 44, 27, 4)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (106, 45, 34, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (107, 45, 17, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (108, 45, 23, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (109, 46, 37, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (110, 46, 35, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (111, 46, 34, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (112, 47, 3, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (113, 47, 20, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (114, 47, 31, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (115, 48, 28, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (116, 48, 27, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (117, 48, 35, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (118, 49, 2, 3)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (119, 49, 27, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (120, 49, 35, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (121, 49, 34, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (122, 7, 61, 5)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (124, 50, 34, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (126, 50, 35, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (127, 50, 61, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (128, 50, 23, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (129, 50, 28, 5)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (130, 50, 54, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (131, 51, 27, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (132, 51, 28, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (133, 51, 23, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (149, 59, 61, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (150, 59, 23, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (153, 60, 61, 3)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (154, 60, 42, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (157, 61, 61, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Numbers]) VALUES (163, 61, 62, 1)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (6, CAST(N'2021-11-24T00:00:00.000' AS DateTime), 1, 5400000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Nguyễn Văn A', N'0123456789', 3)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (7, CAST(N'2021-12-08T00:00:00.000' AS DateTime), 2, 2220000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Nguyễn Tấn Trung', N'0123456789', 3)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (8, CAST(N'2021-12-08T00:00:00.000' AS DateTime), 3, 47200000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0123456789', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (31, CAST(N'2021-11-25T00:00:00.000' AS DateTime), 4, 5400000, N'Quận 9', N'Ung Luân', N'0382916020', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (32, CAST(N'2021-03-26T00:00:00.000' AS DateTime), 4, 5400000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Trần Văn Văn', N'0382916020', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (34, CAST(N'2021-04-03T00:00:00.000' AS DateTime), 4, 92015000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (35, CAST(N'2021-09-03T00:00:00.000' AS DateTime), 4, 36520000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Nguyền Quỳnh Hương', N'0915837110', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (36, CAST(N'2021-10-03T00:00:00.000' AS DateTime), 4, 49410000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (37, CAST(N'2021-12-03T00:00:00.000' AS DateTime), 4, 33570000, N'234-Thôn Yên Thượng-Xã Phú Nghĩ-Huyện Bù Gia Mập-Tỉnh Bình Phước', N'Nguyễn Trần Tuấn Kiệt', N'0923412321', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (38, CAST(N'2021-01-03T00:00:00.000' AS DateTime), 4, 2790000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (39, CAST(N'2021-02-03T00:00:00.000' AS DateTime), 4, 22047000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (40, CAST(N'2021-03-03T00:00:00.000' AS DateTime), 4, 38070000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (41, CAST(N'2021-04-03T00:00:00.000' AS DateTime), 4, 3780000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (42, CAST(N'2021-05-03T00:00:00.000' AS DateTime), 4, 117972000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (43, CAST(N'2021-06-03T00:00:00.000' AS DateTime), 4, 25515000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (44, CAST(N'2021-07-03T00:00:00.000' AS DateTime), 4, 164635008, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (45, CAST(N'2021-08-03T00:00:00.000' AS DateTime), 4, 21672000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (46, CAST(N'2021-09-03T00:00:00.000' AS DateTime), 4, 45540000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (47, CAST(N'2021-10-03T00:00:00.000' AS DateTime), 4, 13350000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 4)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (48, CAST(N'2021-12-03T00:00:00.000' AS DateTime), 4, 30415000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 1)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (49, CAST(N'2021-12-06T00:00:00.000' AS DateTime), 4, 53860000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 1)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (50, CAST(N'2021-12-08T00:00:00.000' AS DateTime), 2, 47927000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0123456789', 1)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (51, CAST(N'2021-12-08T00:00:00.000' AS DateTime), 2, 25807000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0123456789', 1)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (59, CAST(N'2021-12-08T00:00:00.000' AS DateTime), 4, 1152000, N'239-Thôn Hiếu Phong-Xã Bình Tân-Huyện Phú Riềng-Tỉnh Bình Phước', N'Ung Nguyễn Trường Luân', N'0915837119', 1)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (60, CAST(N'2021-12-08T00:00:00.000' AS DateTime), 4, 1035000, NULL, NULL, NULL, 6)
INSERT [dbo].[Orders] ([Id], [Date], [CustomerId], [Total], [Address], [Name], [NumberPhone], [OrderStatusId]) VALUES (61, CAST(N'2021-12-08T00:00:00.000' AS DateTime), 6, 2260000, N'97-Man Thiện-Hiệp Phú-TP Thủ Đức-TP.HCM', N'Nguyễn Văn A', N'0382916020', 2)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([Id], [Status]) VALUES (1, N'Ordered')
INSERT [dbo].[OrderStatus] ([Id], [Status]) VALUES (2, N'Delivered')
INSERT [dbo].[OrderStatus] ([Id], [Status]) VALUES (3, N'Canceled')
INSERT [dbo].[OrderStatus] ([Id], [Status]) VALUES (4, N'Finished')
INSERT [dbo].[OrderStatus] ([Id], [Status]) VALUES (6, N'Buying')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (1, N'Tổ Yến Trắng Nguyên Sợi                                                                                                                                                                                                                                        ', 1, N'Là loại tổ yến thông dụng nhất trên thị trường vì sản lượng nhiều hơn và giá thành cũng thấp hơn so với Yến hồng, Yến huyết.', NULL, 1, 1, 10, 6000000, N'gram', NULL, CAST(N'2021-12-01T00:00:00.000' AS DateTime), 1, 100, 24, CAST(N'2021-01-01T00:00:00.000' AS DateTime), N'Việt Nam', 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (2, N'Yến Huyết – Tổ Yến Cao Cấp                                                                                                                                                                                                                                     ', 3, N' Huyết yến có màu đỏ là do sự tương tác giữa nước bọt của chim yến với các khoáng chất tự nhiên như sắt, canxi, magie… trên vách đá hang động. Yến huyết thường có giá thành cao hơn các loại tổ yến khác do sự khan hiếm và giá trị dinh dưỡng mang lại.', N'Tổ Yến Huyết là loại thực phẩm dinh dưỡng thiên nhiên, bổ dưỡng bậc nhất cho sức khỏe con người với hơn 31 nguyên tố đa vi lượng, rất giàu Ca, Fe./nNgoài ra, trong thành phần yến sào còn có 18 acid amin, một số có hàm lượng rất cao chất dinh dưỡng Giúp điều trị ung thư', 1, 1, 12, 1500000, N'gram', CAST(N'2021-10-20T00:00:00.000' AS DateTime), NULL, 1, 100, 24, CAST(N'2021-01-01T00:00:00.000' AS DateTime), N'Việt Nam', 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (3, N'Yến Hồng – Yến Sào Sợi Nguyên Chất Loại Cao Cấp                                                                                                                                                                                                                ', 2, N'là tổ yến có màu hồng nhạt, có khi hơi cam nhưng màu sắc có thể thay đổi từ màu vỏ quýt đến màu vàng lòng trứng. Số lượng hồng yến khá ít, chỉ chiếm khoảng hơn 10% tổng sản lượng khai thác.', N'Tổ Yến Hồng là loại thực phẩm dinh dưỡng thiên nhiên, bổ dưỡng bậc nhất cho sức khỏe con người với hơn 31 nguyên tố đa vi lượng, rất giàu Ca, Fe. Trong yến sào các nguyên tố có ích cho ổn định thần kinh, trí nhớ như Mn, Br, Cu, Zn có hàm lượng cao…/nNgoài ra, trong thành phần yến sào còn có 18 acid amin, một số có hàm lượng rất cao như Acid aspartic, Serine, Tyrosine, Leucine, …là những chất có tác dụng phục hồi nhanh chóng các tổn thương khi bị nhiễm xạ hoặc chất độc hại.', 1, 1, 25, 7000000, N'gram', CAST(N'2021-10-20T00:00:00.000' AS DateTime), NULL, 1, 100, 24, CAST(N'2021-01-01T00:00:00.000' AS DateTime), N'Việt Nam', 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (17, N'Yến Chân Phương                                                                                                                                                                                                                                                ', 1, N'Công dụng Thượng Vy Yến Nhân Sâm - Yến Sào Thiên Nhiên Cao Cấp
- Cải thiện tâm trạng, trí nhớ.
- Bổ sung năng lượng cho cơ thể.', NULL, 1, 1, 10, 1200000, N'lọ', NULL, CAST(N'2021-11-18T00:00:00.000' AS DateTime), 1, 12, 12, CAST(N'2021-11-17T00:00:00.000' AS DateTime), N'Việt Nam', 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (20, N'Tổ yến trắng tinh chế                                                                                                                                                                                                                                          ', 1, N'Tổ Yến Trắng Tinh Chế: là tổ yến được ngâm nở hoàn toàn và được làm sạch 100% lông tơ, tạp chất. Sau đó sử dụng khuôn để định hình và sấy khô bằng quạt.', NULL, 1, 1, 5, 1800000, N'gram', NULL, CAST(N'2021-11-19T00:00:00.000' AS DateTime), 1, 100, 12, CAST(N'2021-11-03T00:00:00.000' AS DateTime), N'Việt Nam', 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (23, N'Yến Nhân Sâm Bổ Lượng                                                                                                                                                                                                                                          ', 7, N'Công dụng Thượng Vy Yến Nhân Sâm - Yến Sào Thiên Nhiên Cao Cấp
- Cải thiện tâm trạng, trí nhớ.
- Bổ sung năng lượng cho cơ thể.
- Giảm đường huyết, hỗ trợ điều trị bệnh tiểu đường.', NULL, 1, 1, 10, 880000, N'gram', NULL, CAST(N'2021-12-06T00:00:00.000' AS DateTime), 32, 6, 12, CAST(N'2021-10-01T00:00:00.000' AS DateTime), N'Việt Nam', 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (27, N'Yến Hồng Thiên Nhiên                                                                                                                                                                                                                                           ', 2, N'Tổ Yến Hồng là một trong những thực phẩm dinh dưỡng tốt nhất đối với sức khỏe con người tốt cho: trẻ em, phụ nữ mang thai và cho con bú, phụ nữ cần làm đẹp,người gầy yếu, sức đề kháng kém, người cao tuổi, người bệnh, đang điều trị bệnh hoặc mới ốm dậy.', NULL, 1, 1, 5, 26000000, N'gram', NULL, CAST(N'2021-11-19T00:00:00.000' AS DateTime), 1, 100, 24, CAST(N'2021-11-19T00:00:00.000' AS DateTime), N'Việt Nam', 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (28, N'Yến Đông Trùng Hạ Thảo - Nhà Yến Nha Trang                                                                                                                                                                                                                     ', 7, N'Tăng cường chức năng của hệ hô hấp, giảm dị ứng và viêm nhánh khí quản, hen suyễn.
Giảm lượng cholesterol trong máu, giúp ổn định huyết áp cho người bị cao huyết áp.
Tăng khả năng miễn dịch cao, nâng cao sức đề kháng của cơ thể.', NULL, 1, 1, 10, 350000, N'lọ', CAST(N'2021-11-19T00:00:00.000' AS DateTime), NULL, 1, 6, 24, CAST(N'2021-11-19T00:00:00.000' AS DateTime), N'Việt Nam', 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (31, N'Bạch Yến Tinh Chế - Yến Mộc                                                                                                                                                                                                                                    ', 1, N'Tăng cường hệ miễn dịch & làm chậm sự phát triển của AIDS: Ăn tổ yến phục hồi sức khỏe của bệnh nhân sau phẫu thuật và sau bệnh tật. Đặc biệt là tăng cường hệ thống miễn dịch và chức năng của hệ nội tiết. Giúp điều trị ung thư.', NULL, 1, 1, 5, 1200000, N'gram', CAST(N'2021-11-19T00:00:00.000' AS DateTime), NULL, 38, 50, 12, CAST(N'2021-11-19T00:00:00.000' AS DateTime), N'Việt Nam', 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (33, N'Yến Nhân Sâm Thượng Hạng - Yến Bắc Kinh                                                                                                                                                                                                                        ', 7, N'Tăng cường hệ miễn dịch & làm chậm sự phát triển của AIDS: Tổ yến có thể dùng cho các nhóm tuổi khác nhau cả nam và nữ. Ăn tổ yến phục hồi sức khỏe của bệnh nhân sau phẫu thuật và sau bệnh tật.', NULL, 0, 1, 5, 5000000, N'lọ', CAST(N'2021-11-19T00:00:00.000' AS DateTime), NULL, 34, 6, 12, CAST(N'2021-11-19T00:00:00.000' AS DateTime), N'Việt Nam', 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (34, N'YẾN HUYẾT ĐẢO THƯỢNG HẠNG KHÁNH HÒA NEST - 100G                                                                                                                                                                                                                ', 3, N'Tổ Yến Hồng Huyết rất giàu chất khoáng có chứa 18 loại axit amin cùng 31 nguyên tố vi lượng cần thiết cho cơ thể con người, 7 loại đường thiết yếu. Hàm lượng protein chiếm đến 50-60%. đem lại nhiều tác dụng tuyệt vời cho sức khỏe người dùng.', NULL, 1, 1, 10, 22000000, N'gram', NULL, CAST(N'2021-11-19T00:00:00.000' AS DateTime), 37, 100, 24, CAST(N'2021-11-19T00:00:00.000' AS DateTime), N'Việt Nam', 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (35, N'Hồng Yến Thượng Hạn - Bình Định                                                                                                                                                                                                                                ', 2, N'Hồng yến là loại tổ yến sào có giá trị và chất lượng, độ quý hiếm chỉ xếp sau yến huyết.
Quá trình hình thành màu sắc của hồng yến được cho là do quá trình tương tác, lên men của tổ yến với môi trường sống xung quanh tổ.', NULL, 0, 1, 10, 6000000, N'gram', CAST(N'2021-11-19T00:00:00.000' AS DateTime), NULL, 39, 100, 12, CAST(N'2021-11-19T00:00:00.000' AS DateTime), N'Việt Nam', 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (36, N'Huyết Yến Tinh Chế Hảo Hạn - Khánh Hòa Nest                                                                                                                                                                                                                    ', 3, N'Yến huyết lên màu tự nhiên thường chỉ đạt được màu đỏ cam, thậm chí các tổ trong cùng một hộp yến độ lên màu cũng đậm nhạt khác nhau, rất hiếm khi có màu đỏ thẫm đồng đều như rất nhiều các sản phẩm yến huyết khác trên thị trường.', NULL, 1, 1, 10, 25000000, N'gram', CAST(N'2021-11-19T00:00:00.000' AS DateTime), NULL, 37, 100, 24, CAST(N'2021-11-19T00:00:00.000' AS DateTime), N'Việt Nam', 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (37, N'Yến Trắng Thô - Nhà yến Nha Trang                                                                                                                                                                                                                              ', 1, N'Trong thành phần yến sào còn có 18 acid amin, một số có hàm lượng rất cao như Acid aspartic, Serine, Tyrosine, Leucine, …là những chất có tác dụng phục hồi nhanh chóng các tổn thương khi bị nhiễm xạ hoặc chất độc hại.', NULL, 0, 1, 10, 600000, N'gram', CAST(N'2021-11-19T00:00:00.000' AS DateTime), NULL, 1, 100, 12, CAST(N'2021-11-19T00:00:00.000' AS DateTime), N'Việt Nam', 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (39, N'Huyết Yến Cao Cấp - Nhà Yến Nha Trang                                                                                                                                                                                                                          ', 3, N'Tổ Yến Huyết (hay còn gọi là huyết yến) là loại tổ yến có màu đỏ tươi hoặc đỏ thẩm. Huyết yến có màu đỏ là do sự tương tác giữa nước bọt của chim yến với các khoáng chất tự nhiên như sắt, canxi, magie… trên vách đá hang động.', NULL, 1, 1, 5, 15000000, N'gram', CAST(N'2021-11-19T00:00:00.000' AS DateTime), NULL, 1, 100, 36, CAST(N'2021-11-19T00:00:00.000' AS DateTime), N'Việt Nam', 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (42, N'Tesst                                                                                                                                                                                                                                                          ', 1, N'Mô tả sản phẩm', NULL, 0, 0, 1, 250000, N'gram', NULL, CAST(N'2021-12-01T00:00:00.000' AS DateTime), 37, 1, 1, CAST(N'2021-11-21T00:00:00.000' AS DateTime), N'Trung Quốc', 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (54, N'Yến Trưng - Trung Quốc                                                                                                                                                                                                                                         ', 1, N'Tổ Yến Huyết (hay còn gọi là huyết yến) là loại tổ yến có màu đỏ tươi hoặc đỏ thẩm. Huyết yến có màu đỏ là do sự tương tác giữa nước bọt của chim yến với các khoáng chất tự nhiên như sắt, canxi, magie… trên vách đá hang động.', NULL, 0, 0, 20, 250000, N'gram', NULL, CAST(N'2021-12-06T00:00:00.000' AS DateTime), 37, 50, 12, CAST(N'2021-12-06T00:00:00.000' AS DateTime), N'Trung Quốc', 2)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (60, N'Thanh Âmqưe                                                                                                                                                                                                                                                    ', 1, N'2112', NULL, 0, 0, 121, 1231321312, N'lọ', NULL, CAST(N'2021-12-08T00:00:00.000' AS DateTime), 40, 12, 2, CAST(N'2021-12-06T00:00:00.000' AS DateTime), N'Việt Nam', 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (61, N'Thanh Âm                                                                                                                                                                                                                                                       ', 7, N'Sản phẩm yến nguyên chất giúp tăng sức khỏe cho tất cả mọi người', NULL, 1, 0, 10, 200000, N'gram', CAST(N'2021-12-08T00:00:00.000' AS DateTime), NULL, 1, 100, 12, CAST(N'2021-12-08T00:00:00.000' AS DateTime), N'Trung Quốc', 3)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [Description], [Detail], [Highlight], [NewProduction], [Sale], [Price], [Unit], [CreatedAt], [UpdatedAt], [BranchId], [Weight], [Expiry], [ManufacturingDate], [Origin], [SupplierId]) VALUES (62, N'Huyết Yên cao cấp Bắc Kinh                                                                                                                                                                                                                                     ', 3, N'Yến sào chất lượng cao, được kiểm tra và sản xuất bằng dây chuyền hiện đại nhất để đảm bảo được chất lượng của sản phẩm.', NULL, 0, 0, 5, 2000000, N'gram', NULL, CAST(N'2021-12-08T00:00:00.000' AS DateTime), 34, 100, 24, CAST(N'2021-12-08T00:00:00.000' AS DateTime), N'Trung Quốc', 5)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([Id], [Name], [Address], [Phone]) VALUES (2, N'Nhà yến Nha Trang', N'Thôn Vĩnh Châu, Xã Vĩnh Hiệp, Thành phố Nha Trang, Tỉnh Khánh Hòa', N'0911750850')
INSERT [dbo].[Suppliers] ([Id], [Name], [Address], [Phone]) VALUES (3, N'Công ty Yến Việt', N'Cụm Công Nghiệp Thành Hải, xã Thành Hải, TP. Phan Rang – Tháp Chàm, Ninh Thuận', N'0938271721')
INSERT [dbo].[Suppliers] ([Id], [Name], [Address], [Phone]) VALUES (5, N'Công ty nhập khẩu yến Tân Cương', N'97-Man Thiện-TP.Thủ Đức-TP.HCM', N'0382916032')
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Email], [Password], [Role], [Enable]) VALUES (16, N'ungluan@gmail.com', N'$2a$12$6UD2s57hjYHTLcohrOyJzOizz/DWSA1/lkg/ra/8Q9fcdKEyVTv12                                        ', N'USER      ', 1)
INSERT [dbo].[Users] ([Id], [Email], [Password], [Role], [Enable]) VALUES (17, N'ungluan1@gmail.com', N'$2a$10$SukjwDUoM1Gno6qDjWoDCOixA6qaWzjSEWjlP3Ksm3Z60iRQSBZfq                                        ', N'USER      ', 1)
INSERT [dbo].[Users] ([Id], [Email], [Password], [Role], [Enable]) VALUES (18, N'anhanh@gmail.com', N'$2a$10$SukjwDUoM1Gno6qDjWoDCOixA6qaWzjSEWjlP3Ksm3Z60iRQSBZfq                                        ', N'ADMIN     ', 1)
INSERT [dbo].[Users] ([Id], [Email], [Password], [Role], [Enable]) VALUES (19, N'bjergsen@gmail.com', N'$2a$10$SukjwDUoM1Gno6qDjWoDCOixA6qaWzjSEWjlP3Ksm3Z60iRQSBZfq                                        ', N'ADMIN     ', 1)
INSERT [dbo].[Users] ([Id], [Email], [Password], [Role], [Enable]) VALUES (20, N'saigon1975@gmail.com', N'$2a$12$5pgwabEJ6W3ndtIRGXBnSutGNdnEB3ptHudrUKAYT5bNIPYKa4uXq                                        ', N'USER      ', 1)
INSERT [dbo].[Users] ([Id], [Email], [Password], [Role], [Enable]) VALUES (21, N'ungluan6@gmail.com', N'$2a$12$mEoK7KCxdKqsavzZ/9yZq.aSvUdioHe.VQN/YwvnHFdyPlzWISxTi                                        ', N'ROLE_USER ', 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [U_BranchName]    Script Date: 12/8/2021 10:22:56 PM ******/
ALTER TABLE [dbo].[Branchs] ADD  CONSTRAINT [U_BranchName] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Unit_Name_Products]    Script Date: 12/8/2021 10:22:56 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Unit_Name_Products] ON [dbo].[Products]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Infomations_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Infomations_Users]
GO
ALTER TABLE [dbo].[Images]  WITH CHECK ADD  CONSTRAINT [FK_Images_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Images] CHECK CONSTRAINT [FK_Images_Products]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_DatHang] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_DatHang]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_DatHang_Infomations] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_DatHang_Infomations]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_OrderStatus] FOREIGN KEY([OrderStatusId])
REFERENCES [dbo].[OrderStatus] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_OrderStatus]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Branchs] FOREIGN KEY([BranchId])
REFERENCES [dbo].[Branchs] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Branchs]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Suppliers] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
USE [master]
GO
ALTER DATABASE [YENSAO] SET  READ_WRITE 
GO
