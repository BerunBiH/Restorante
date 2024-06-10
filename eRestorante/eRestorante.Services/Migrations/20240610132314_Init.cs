using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestorante.Services.Migrations
{
    /// <inheritdoc />
    public partial class Init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Category",
                columns: table => new
                {
                    CategoryID = table.Column<int>(type: "int", nullable: false),
                    CategoryName = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Category", x => x.CategoryID);
                });

            migrationBuilder.CreateTable(
                name: "Customers",
                columns: table => new
                {
                    CustomerID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CustomerName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CustomerSurname = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CustomerEmail = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CustomerPhone = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CustomerPassHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CustomerPassSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CustomerDateRegister = table.Column<DateOnly>(type: "date", nullable: false),
                    CustomerImage = table.Column<byte[]>(type: "image", nullable: true),
                    CustomerStatus = table.Column<byte>(type: "tinyint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Customer__A4AE64B810B8D511", x => x.CustomerID);
                });

            migrationBuilder.CreateTable(
                name: "Roles",
                columns: table => new
                {
                    RolesID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RoleName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    RoleDescription = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Roles__C4B2782012A27FF4", x => x.RolesID);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    UserID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserSurname = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserEmail = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserPhone = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserPassHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserPassSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserStatus = table.Column<byte>(type: "tinyint", nullable: true),
                    UserImage = table.Column<byte[]>(type: "image", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Users__1788CCAC809260E0", x => x.UserID);
                });

            migrationBuilder.CreateTable(
                name: "Dishes",
                columns: table => new
                {
                    DishID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DishName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DishDescription = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DishCost = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    DishImage = table.Column<byte[]>(type: "image", nullable: true),
                    CategoryID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Dishes__18834F7047BD2687", x => x.DishID);
                    table.ForeignKey(
                        name: "FK_IB200192_Category",
                        column: x => x.CategoryID,
                        principalTable: "Category",
                        principalColumn: "CategoryID");
                });

            migrationBuilder.CreateTable(
                name: "Drinks",
                columns: table => new
                {
                    DrinkID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DrinkName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DrinkDescription = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DrinkCost = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    DrinkAlcoholPerc = table.Column<decimal>(type: "decimal(10,2)", nullable: true),
                    DrinkImage = table.Column<byte[]>(type: "image", nullable: true),
                    CategoryID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Drinks__C094D3C8012B46A1", x => x.DrinkID);
                    table.ForeignKey(
                        name: "FK_IB200192_Category_Drink",
                        column: x => x.CategoryID,
                        principalTable: "Category",
                        principalColumn: "CategoryID");
                });

            migrationBuilder.CreateTable(
                name: "Orders",
                columns: table => new
                {
                    OrdersID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OrderNumber = table.Column<int>(type: "int", nullable: false),
                    OrderDate = table.Column<DateOnly>(type: "date", nullable: false),
                    OrderStatus = table.Column<byte>(type: "tinyint", nullable: true),
                    OrderNullified = table.Column<byte>(type: "tinyint", nullable: true),
                    CustomerID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Orders__630B9956504462F5", x => x.OrdersID);
                    table.ForeignKey(
                        name: "FK_IB200192_Customers",
                        column: x => x.CustomerID,
                        principalTable: "Customers",
                        principalColumn: "CustomerID");
                });

            migrationBuilder.CreateTable(
                name: "Reservations",
                columns: table => new
                {
                    ReservationID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ReservationDate = table.Column<DateOnly>(type: "date", nullable: false),
                    ReservationTime = table.Column<TimeOnly>(type: "time", nullable: false),
                    NumberOfGuests = table.Column<int>(type: "int", nullable: false),
                    NumberOfHours = table.Column<int>(type: "int", nullable: false),
                    CustomerID = table.Column<int>(type: "int", nullable: true),
                    ReservationReason = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    NumberOfMinors = table.Column<int>(type: "int", nullable: true),
                    ContactPhone = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    SpecialWishes = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Reservat__B7EE5F04ADF6B8A2", x => x.ReservationID);
                    table.ForeignKey(
                        name: "FK_IB200192_Customer_Reservation",
                        column: x => x.CustomerID,
                        principalTable: "Customers",
                        principalColumn: "CustomerID");
                });

            migrationBuilder.CreateTable(
                name: "CommentStaff",
                columns: table => new
                {
                    CommentStaffID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CommentDate = table.Column<DateOnly>(type: "date", nullable: false),
                    CommentText = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CustomerID = table.Column<int>(type: "int", nullable: true),
                    UserID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__CommentS__9A145DB5814E5E59", x => x.CommentStaffID);
                    table.ForeignKey(
                        name: "FK_IB200192_Customer_CommentStaff",
                        column: x => x.CustomerID,
                        principalTable: "Customers",
                        principalColumn: "CustomerID");
                    table.ForeignKey(
                        name: "FK_IB200192_User_Comment",
                        column: x => x.UserID,
                        principalTable: "Users",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "RatingStaff",
                columns: table => new
                {
                    RatingStaffID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RatingNumber = table.Column<int>(type: "int", nullable: false),
                    RatingDate = table.Column<DateOnly>(type: "date", nullable: false),
                    CustomerID = table.Column<int>(type: "int", nullable: true),
                    UserID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__RatingSt__EDBBA03936960BC7", x => x.RatingStaffID);
                    table.ForeignKey(
                        name: "FK_IB200192_Customer_RatingStaff",
                        column: x => x.CustomerID,
                        principalTable: "Customers",
                        principalColumn: "CustomerID");
                    table.ForeignKey(
                        name: "FK_IB200192_User_Ratings",
                        column: x => x.UserID,
                        principalTable: "Users",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "UserRoles",
                columns: table => new
                {
                    UserRolesID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: true),
                    RoleID = table.Column<int>(type: "int", nullable: true),
                    DateChange = table.Column<DateOnly>(type: "date", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__UserRole__43D8C0CD687CEE77", x => x.UserRolesID);
                    table.ForeignKey(
                        name: "FK_IB200192_Roles",
                        column: x => x.RoleID,
                        principalTable: "Roles",
                        principalColumn: "RolesID");
                    table.ForeignKey(
                        name: "FK_IB200192_Users",
                        column: x => x.UserID,
                        principalTable: "Users",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "CommentDish",
                columns: table => new
                {
                    CommentDishID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CommentDate = table.Column<DateOnly>(type: "date", nullable: false),
                    CommentText = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CustomerID = table.Column<int>(type: "int", nullable: true),
                    DishID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__CommentD__2FDAB8BD7D59C56C", x => x.CommentDishID);
                    table.ForeignKey(
                        name: "FK_IB200192_Customer_CommentDish",
                        column: x => x.CustomerID,
                        principalTable: "Customers",
                        principalColumn: "CustomerID");
                    table.ForeignKey(
                        name: "FK_IB200192_Dishes_Comment",
                        column: x => x.DishID,
                        principalTable: "Dishes",
                        principalColumn: "DishID");
                });

            migrationBuilder.CreateTable(
                name: "RatingDish",
                columns: table => new
                {
                    RatingID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RatingNumber = table.Column<int>(type: "int", nullable: false),
                    RatingDate = table.Column<DateOnly>(type: "date", nullable: false),
                    CustomerID = table.Column<int>(type: "int", nullable: true),
                    DishID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__RatingDi__FCCDF85CB77426E4", x => x.RatingID);
                    table.ForeignKey(
                        name: "FK_IB200192_Customer_Ratings",
                        column: x => x.CustomerID,
                        principalTable: "Customers",
                        principalColumn: "CustomerID");
                    table.ForeignKey(
                        name: "FK_IB200192_Dishes_Ratings",
                        column: x => x.DishID,
                        principalTable: "Dishes",
                        principalColumn: "DishID");
                });

            migrationBuilder.CreateTable(
                name: "OrderDish",
                columns: table => new
                {
                    OrderDishID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OrderQuantity = table.Column<int>(type: "int", nullable: false),
                    OrderID = table.Column<int>(type: "int", nullable: true),
                    DishID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__OrderDis__7F00FA2003A4B710", x => x.OrderDishID);
                    table.ForeignKey(
                        name: "FK_IB200192_Dishes",
                        column: x => x.DishID,
                        principalTable: "Dishes",
                        principalColumn: "DishID");
                    table.ForeignKey(
                        name: "FK_IB200192_Orders",
                        column: x => x.OrderID,
                        principalTable: "Orders",
                        principalColumn: "OrdersID");
                });

            migrationBuilder.CreateTable(
                name: "OrderDrink",
                columns: table => new
                {
                    OrderDrinkID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OrderQuantity = table.Column<int>(type: "int", nullable: false),
                    OrderID = table.Column<int>(type: "int", nullable: true),
                    DrinkID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__OrderDri__DA4E39D7C654E395", x => x.OrderDrinkID);
                    table.ForeignKey(
                        name: "FK_IB200192_Drink",
                        column: x => x.DrinkID,
                        principalTable: "Drinks",
                        principalColumn: "DrinkID");
                    table.ForeignKey(
                        name: "FK_IB200192_Order_Drink",
                        column: x => x.OrderID,
                        principalTable: "Orders",
                        principalColumn: "OrdersID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_CommentDish_CustomerID",
                table: "CommentDish",
                column: "CustomerID");

            migrationBuilder.CreateIndex(
                name: "IX_CommentDish_DishID",
                table: "CommentDish",
                column: "DishID");

            migrationBuilder.CreateIndex(
                name: "IX_CommentStaff_CustomerID",
                table: "CommentStaff",
                column: "CustomerID");

            migrationBuilder.CreateIndex(
                name: "IX_CommentStaff_UserID",
                table: "CommentStaff",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_Dishes_CategoryID",
                table: "Dishes",
                column: "CategoryID");

            migrationBuilder.CreateIndex(
                name: "IX_Drinks_CategoryID",
                table: "Drinks",
                column: "CategoryID");

            migrationBuilder.CreateIndex(
                name: "IX_OrderDish_DishID",
                table: "OrderDish",
                column: "DishID");

            migrationBuilder.CreateIndex(
                name: "IX_OrderDish_OrderID",
                table: "OrderDish",
                column: "OrderID");

            migrationBuilder.CreateIndex(
                name: "IX_OrderDrink_DrinkID",
                table: "OrderDrink",
                column: "DrinkID");

            migrationBuilder.CreateIndex(
                name: "IX_OrderDrink_OrderID",
                table: "OrderDrink",
                column: "OrderID");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_CustomerID",
                table: "Orders",
                column: "CustomerID");

            migrationBuilder.CreateIndex(
                name: "IX_RatingDish_CustomerID",
                table: "RatingDish",
                column: "CustomerID");

            migrationBuilder.CreateIndex(
                name: "IX_RatingDish_DishID",
                table: "RatingDish",
                column: "DishID");

            migrationBuilder.CreateIndex(
                name: "IX_RatingStaff_CustomerID",
                table: "RatingStaff",
                column: "CustomerID");

            migrationBuilder.CreateIndex(
                name: "IX_RatingStaff_UserID",
                table: "RatingStaff",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_Reservations_CustomerID",
                table: "Reservations",
                column: "CustomerID");

            migrationBuilder.CreateIndex(
                name: "IX_UserRoles_RoleID",
                table: "UserRoles",
                column: "RoleID");

            migrationBuilder.CreateIndex(
                name: "IX_UserRoles_UserID",
                table: "UserRoles",
                column: "UserID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CommentDish");

            migrationBuilder.DropTable(
                name: "CommentStaff");

            migrationBuilder.DropTable(
                name: "OrderDish");

            migrationBuilder.DropTable(
                name: "OrderDrink");

            migrationBuilder.DropTable(
                name: "RatingDish");

            migrationBuilder.DropTable(
                name: "RatingStaff");

            migrationBuilder.DropTable(
                name: "Reservations");

            migrationBuilder.DropTable(
                name: "UserRoles");

            migrationBuilder.DropTable(
                name: "Drinks");

            migrationBuilder.DropTable(
                name: "Orders");

            migrationBuilder.DropTable(
                name: "Dishes");

            migrationBuilder.DropTable(
                name: "Roles");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Customers");

            migrationBuilder.DropTable(
                name: "Category");
        }
    }
}
