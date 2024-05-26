using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class DrinkUpdateRequest
    {
        public string DrinkName { get; set; } = null!;

        public string DrinkDescription { get; set; } = null!;

        public decimal DrinkCost { get; set; }

        public decimal? DrinkAlcoholPerc { get; set; }

        public byte[]? DrinkImage { get; set; }

    }
}
