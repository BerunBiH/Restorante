using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class Customer
{
    public int CustomerId { get; set; }

    public string CustomerName { get; set; } = null!;

    public string CustomerSurname { get; set; } = null!;

    public string CustomerEmail { get; set; } = null!;

    public string CustomerPhone { get; set; } = null!;

    public string CustomerPassHash { get; set; } = null!;

    public string CustomerPassSalt { get; set; } = null!;

    public DateOnly CustomerDateRegister { get; set; }

    public byte[]? CustomerImage { get; set; }

    public byte? CustomerStatus { get; set; }

    public virtual ICollection<CommentDish> CommentDishes { get; set; } = new List<CommentDish>();

    public virtual ICollection<CommentStaff> CommentStaffs { get; set; } = new List<CommentStaff>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<RatingDish> RatingDishes { get; set; } = new List<RatingDish>();

    public virtual ICollection<RatingStaff> RatingStaffs { get; set; } = new List<RatingStaff>();

    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();
}
