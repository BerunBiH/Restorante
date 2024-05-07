using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class Drink
{
    public int DrinkId { get; set; }

    public string DrinkName { get; set; } = null!;

    public string DrinkDescription { get; set; } = null!;

    public decimal DrinkCost { get; set; }

    public decimal? DrinkAlcoholPerc { get; set; }

    public byte[]? DrinkImage { get; set; }

    public int? CategoryId { get; set; }

    public virtual Category? Category { get; set; }

    public virtual ICollection<OrderDrink> OrderDrinks { get; set; } = new List<OrderDrink>();
}
