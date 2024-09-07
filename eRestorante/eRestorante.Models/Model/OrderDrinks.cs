using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Model
{
    public partial class OrderDrinks
    {
        public int OrderDrinkId { get; set; }

        public int OrderQuantity { get; set; }

        public int? OrderId { get; set; }

        public int? DrinkId { get; set; }

    }
}
