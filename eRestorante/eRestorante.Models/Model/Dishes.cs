using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Model
{
    public partial class Dishes
    {
        public int DishID { get; set; }
        public string DishName { get; set; }
        public string DishDescription { get; set; }
        public decimal DishCost { get; set; }
        public int CategoryId { get; set; }
        public byte[] DishImage { get; set; }
        public bool Speciality { get; set; }
    }
}
