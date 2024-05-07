using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Model
{
    public partial class Dishes
    {
        public int DishID { get; set; }
        public string DishName { get; set; }
        public string DishDescription { get; set; }
        public decimal DishCost { get; set; }
        public int CategoryID { get; set; }
        public byte[] DishImageID { get; set; }
    }
}
