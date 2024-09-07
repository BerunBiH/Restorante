using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Model
{
    public partial class Order
    {
        public int OrdersId { get; set; }

        public int OrderNumber { get; set; }

        public DateOnly OrderDate { get; set; }

        public byte? OrderStatus { get; set; } = 0;

        public byte? OrderNullified { get; set; } = 0;

        public int? CustomerId { get; set; }

        public virtual ICollection<OrderDishes> OrderDishes { get; set; } = new List<OrderDishes>();

        public virtual ICollection<OrderDrinks> OrderDrinks { get; set; } = new List<OrderDrinks>();
    }
}
