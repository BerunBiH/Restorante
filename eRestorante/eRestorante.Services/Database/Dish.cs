using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class Dish
{
    public int DishId { get; set; }

    public string DishName { get; set; } = null!;

    public string DishDescription { get; set; } = null!;

    public decimal DishCost { get; set; }

    public byte[]? DishImage { get; set; }

    public int? CategoryId { get; set; }

    public virtual Category? Category { get; set; }

    public virtual ICollection<CommentDish> CommentDishes { get; set; } = new List<CommentDish>();

    public virtual ICollection<OrderDish> OrderDishes { get; set; } = new List<OrderDish>();

    public virtual ICollection<RatingDish> RatingDishes { get; set; } = new List<RatingDish>();
}
