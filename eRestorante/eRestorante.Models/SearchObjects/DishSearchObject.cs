using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.SearchObjects
{
    public class DishSearchObject:BaseSearchObject
    {
        public string? DishName { get; set; }
        public decimal? DishCost { get; set; }
    }
}
