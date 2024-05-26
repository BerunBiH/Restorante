using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.SearchObjects
{
    public class DrinkSearchObject:BaseSearchObject
    {
        public string? DrinkName { get; set; }
        public decimal? DrinkCost { get; set; }
    }
}
