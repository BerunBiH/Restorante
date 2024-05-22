using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class DishInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        [MinLength(2)]
        [MaxLength(50)]
        public string DishName { get; set; }

        [Required(AllowEmptyStrings = false)]
        [MinLength(2)]
        [MaxLength(50)]
        public string DishDescription { get; set; }

        [Required]
        [Range(0, 1000)]
        public decimal DishCost { get; set; }
        public int CategoryID { get; set; }
        public byte[] DishImageID { get; set; }
    }
}
