using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class Category
{
    public int CategoryId { get; set; }

    public string CategoryName { get; set; } = null!;

    public virtual ICollection<Dish> Dishes { get; set; } = new List<Dish>();

    public virtual ICollection<Drink> Drinks { get; set; } = new List<Drink>();
}
