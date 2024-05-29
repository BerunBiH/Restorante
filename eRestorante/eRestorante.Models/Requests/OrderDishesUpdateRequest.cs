using eRestorante.Models.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class OrderDishesUpdateRequest
    {
        [Required(ErrorMessage = "This field can not be empty.")]
        [Range(1, 1000, ErrorMessage = "The order quantity can be in a range from 1 to 100")]
        public int OrderQuantity { get; set; }
    }
}
