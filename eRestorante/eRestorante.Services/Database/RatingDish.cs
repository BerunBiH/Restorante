using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class RatingDish
{
    public int RatingId { get; set; }

    public int RatingNumber { get; set; }

    public DateOnly RatingDate { get; set; }

    public int? CustomerId { get; set; }

    public int? DishId { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual Dish? Dish { get; set; }
}
