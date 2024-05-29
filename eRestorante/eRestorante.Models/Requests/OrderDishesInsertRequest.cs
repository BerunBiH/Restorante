using eRestorante.Models.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class OrderDishesInsertRequest
    {
        public int OrderQuantity { get; set; }

        public int? OrderId { get; set; }

        public int? DishId { get; set; }
    }
}
