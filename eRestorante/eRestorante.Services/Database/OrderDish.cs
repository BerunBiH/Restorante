using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class OrderDish
{
    public int OrderDishId { get; set; }

    public int OrderQuantity { get; set; }

    public int? OrderId { get; set; }

    public int? DishId { get; set; }

    public virtual Dish? Dish { get; set; }

    public virtual Order? Order { get; set; }
}
