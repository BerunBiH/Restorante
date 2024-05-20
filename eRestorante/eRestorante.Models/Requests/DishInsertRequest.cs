using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class DishInsertRequest
    {
        public string DishName { get; set; }
        public string DishDescription { get; set; }
        public decimal DishCost { get; set; }
        public int CategoryID { get; set; }
        public byte[] DishImageID { get; set; }
    }
}
