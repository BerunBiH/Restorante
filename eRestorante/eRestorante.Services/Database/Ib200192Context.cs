using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace eRestorante.Services.Database;

public partial class Ib200192Context : DbContext
{
    public Ib200192Context()
    {
    }

    public Ib200192Context(DbContextOptions<Ib200192Context> options)
        : base(options)
    {
    }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<CommentDish> CommentDishes { get; set; }

    public virtual DbSet<CommentStaff> CommentStaffs { get; set; }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<Dish> Dishes { get; set; }

    public virtual DbSet<Drink> Drinks { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDish> OrderDishes { get; set; }

    public virtual DbSet<OrderDrink> OrderDrinks { get; set; }

    public virtual DbSet<RatingDish> RatingDishes { get; set; }

    public virtual DbSet<RatingStaff> RatingStaffs { get; set; }

    public virtual DbSet<Reservation> Reservations { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<UserRole> UserRoles { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=localhost;Initial Catalog=IB200192;Persist Security Info=False;MultipleActiveResultSets=False;Encrypt=False;TrustServerCertificate=False;Connection Timeout=30; Trusted_Connection=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Category>(entity =>
        {
            entity.ToTable("Category");

            entity.Property(e => e.CategoryId)
                .ValueGeneratedNever()
                .HasColumnName("CategoryID");
            entity.Property(e => e.CategoryName)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<CommentDish>(entity =>
        {
            entity.HasKey(e => e.CommentDishId).HasName("PK__CommentD__2FDAB8BD7D59C56C");

            entity.ToTable("CommentDish");

            entity.Property(e => e.CommentDishId).HasColumnName("CommentDishID");
            entity.Property(e => e.CustomerId).HasColumnName("CustomerID");
            entity.Property(e => e.DishId).HasColumnName("DishID");

            entity.HasOne(d => d.Customer).WithMany(p => p.CommentDishes)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK_IB200192_Customer_CommentDish");

            entity.HasOne(d => d.Dish).WithMany(p => p.CommentDishes)
                .HasForeignKey(d => d.DishId)
                .HasConstraintName("FK_IB200192_Dishes_Comment");
        });

        modelBuilder.Entity<CommentStaff>(entity =>
        {
            entity.HasKey(e => e.CommentStaffId).HasName("PK__CommentS__9A145DB5814E5E59");

            entity.ToTable("CommentStaff");

            entity.Property(e => e.CommentStaffId).HasColumnName("CommentStaffID");
            entity.Property(e => e.CustomerId).HasColumnName("CustomerID");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.Customer).WithMany(p => p.CommentStaffs)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK_IB200192_Customer_CommentStaff");

            entity.HasOne(d => d.User).WithMany(p => p.CommentStaffs)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK_IB200192_User_Comment");
        });

        modelBuilder.Entity<Customer>(entity =>
        {
            entity.HasKey(e => e.CustomerId).HasName("PK__Customer__A4AE64B810B8D511");

            entity.Property(e => e.CustomerId).HasColumnName("CustomerID");
            entity.Property(e => e.CustomerImage).HasColumnType("image");
        });

        modelBuilder.Entity<Dish>(entity =>
        {
            entity.HasKey(e => e.DishId).HasName("PK__Dishes__18834F7047BD2687");

            entity.Property(e => e.DishId).HasColumnName("DishID");
            entity.Property(e => e.CategoryId).HasColumnName("CategoryID");
            entity.Property(e => e.DishCost).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.DishImage).HasColumnType("image");

            entity.HasOne(d => d.Category).WithMany(p => p.Dishes)
                .HasForeignKey(d => d.CategoryId)
                .HasConstraintName("FK_IB200192_Category");
        });

        modelBuilder.Entity<Drink>(entity =>
        {
            entity.HasKey(e => e.DrinkId).HasName("PK__Drinks__C094D3C8012B46A1");

            entity.Property(e => e.DrinkId).HasColumnName("DrinkID");
            entity.Property(e => e.CategoryId).HasColumnName("CategoryID");
            entity.Property(e => e.DrinkAlcoholPerc).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.DrinkCost).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.DrinkImage).HasColumnType("image");

            entity.HasOne(d => d.Category).WithMany(p => p.Drinks)
                .HasForeignKey(d => d.CategoryId)
                .HasConstraintName("FK_IB200192_Category_Drink");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.OrdersId).HasName("PK__Orders__630B9956504462F5");

            entity.Property(e => e.OrdersId).HasColumnName("OrdersID");
            entity.Property(e => e.CustomerId).HasColumnName("CustomerID");

            entity.HasOne(d => d.Customer).WithMany(p => p.Orders)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK_IB200192_Customers");
        });

        modelBuilder.Entity<OrderDish>(entity =>
        {
            entity.HasKey(e => e.OrderDishId).HasName("PK__OrderDis__7F00FA2003A4B710");

            entity.ToTable("OrderDish");

            entity.Property(e => e.OrderDishId).HasColumnName("OrderDishID");
            entity.Property(e => e.DishId).HasColumnName("DishID");
            entity.Property(e => e.OrderId).HasColumnName("OrderID");

            entity.HasOne(d => d.Dish).WithMany(p => p.OrderDishes)
                .HasForeignKey(d => d.DishId)
                .HasConstraintName("FK_IB200192_Dishes");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDishes)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK_IB200192_Orders");
        });

        modelBuilder.Entity<OrderDrink>(entity =>
        {
            entity.HasKey(e => e.OrderDrinkId).HasName("PK__OrderDri__DA4E39D7C654E395");

            entity.ToTable("OrderDrink");

            entity.Property(e => e.OrderDrinkId).HasColumnName("OrderDrinkID");
            entity.Property(e => e.DishId).HasColumnName("DishID");
            entity.Property(e => e.OrderId).HasColumnName("OrderID");

            entity.HasOne(d => d.Dish).WithMany(p => p.OrderDrinks)
                .HasForeignKey(d => d.DishId)
                .HasConstraintName("FK_IB200192_Drink");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDrinks)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK_IB200192_Order_Drink");
        });

        modelBuilder.Entity<RatingDish>(entity =>
        {
            entity.HasKey(e => e.RatingId).HasName("PK__RatingDi__FCCDF85CB77426E4");

            entity.ToTable("RatingDish");

            entity.Property(e => e.RatingId).HasColumnName("RatingID");
            entity.Property(e => e.CustomerId).HasColumnName("CustomerID");
            entity.Property(e => e.DishId).HasColumnName("DishID");

            entity.HasOne(d => d.Customer).WithMany(p => p.RatingDishes)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK_IB200192_Customer_Ratings");

            entity.HasOne(d => d.Dish).WithMany(p => p.RatingDishes)
                .HasForeignKey(d => d.DishId)
                .HasConstraintName("FK_IB200192_Dishes_Ratings");
        });

        modelBuilder.Entity<RatingStaff>(entity =>
        {
            entity.HasKey(e => e.RatingStaffId).HasName("PK__RatingSt__EDBBA03936960BC7");

            entity.ToTable("RatingStaff");

            entity.Property(e => e.RatingStaffId).HasColumnName("RatingStaffID");
            entity.Property(e => e.CustomerId).HasColumnName("CustomerID");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.Customer).WithMany(p => p.RatingStaffs)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK_IB200192_Customer_RatingStaff");

            entity.HasOne(d => d.User).WithMany(p => p.RatingStaffs)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK_IB200192_User_Ratings");
        });

        modelBuilder.Entity<Reservation>(entity =>
        {
            entity.HasKey(e => e.ReservationId).HasName("PK__Reservat__B7EE5F04ADF6B8A2");

            entity.Property(e => e.ReservationId).HasColumnName("ReservationID");
            entity.Property(e => e.CustomerId).HasColumnName("CustomerID");

            entity.HasOne(d => d.Customer).WithMany(p => p.Reservations)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK_IB200192_Customer_Reservation");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.RolesId).HasName("PK__Roles__C4B2782012A27FF4");

            entity.Property(e => e.RolesId).HasColumnName("RolesID");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__1788CCAC809260E0");

            entity.Property(e => e.UserId).HasColumnName("UserID");
            entity.Property(e => e.UserImage).HasColumnType("image");
        });

        modelBuilder.Entity<UserRole>(entity =>
        {
            entity.HasKey(e => e.UserRolesId).HasName("PK__UserRole__43D8C0CD687CEE77");

            entity.Property(e => e.UserRolesId).HasColumnName("UserRolesID");
            entity.Property(e => e.RoleId).HasColumnName("RoleID");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.Role).WithMany(p => p.UserRoles)
                .HasForeignKey(d => d.RoleId)
                .HasConstraintName("FK_IB200192_Roles");

            entity.HasOne(d => d.User).WithMany(p => p.UserRoles)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK_IB200192_Users");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
