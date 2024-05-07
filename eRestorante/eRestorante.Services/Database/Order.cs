using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class Order
{
    public int OrdersId { get; set; }

    public int OrderNumber { get; set; }

    public DateOnly OrderDate { get; set; }

    public byte? OrderStatus { get; set; }

    public byte? OrderNullified { get; set; }

    public int? CustomerId { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual ICollection<OrderDish> OrderDishes { get; set; } = new List<OrderDish>();

    public virtual ICollection<OrderDrink> OrderDrinks { get; set; } = new List<OrderDrink>();
}
