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
        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [MinLength(2, ErrorMessage = "The dish name can't be less than 2 characters.")]
        [MaxLength(50, ErrorMessage = "The dish name can't be more than 50 characters.")]
        public string DishName { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [MinLength(2, ErrorMessage = "The dish description can't be less than 2 characters.")]
        [MaxLength(1000, ErrorMessage = "The dish description can't be more than 1000 characters.")]
        public string DishDescription { get; set; }

        [Required(ErrorMessage = "This field can not be empty.")]
        [Range(0, 1000, ErrorMessage ="The dish cost can be in a range from 0 to 1000")]
        public decimal DishCost { get; set; }
        public int CategoryID { get; set; }
        public byte[] DishImageID { get; set; }
    }
}
