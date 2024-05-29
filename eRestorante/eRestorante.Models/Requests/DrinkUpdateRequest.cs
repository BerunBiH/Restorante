using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class DrinkUpdateRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [MinLength(2, ErrorMessage = "The drink name can't be less than 2 characters.")]
        [MaxLength(50, ErrorMessage = "The drink name can't be more than 50 characters.")]
        public string DrinkName { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [MinLength(2, ErrorMessage = "The drink description can't be less than 2 characters.")]
        [MaxLength(1000, ErrorMessage = "The drink description can't be more than 1000 characters.")]
        public string DrinkDescription { get; set; } = null!;

        [Required(ErrorMessage = "This field can not be empty.")]
        [Range(0, 1000, ErrorMessage = "The drink cost can be in a range from 0 to 1000")]
        public decimal DrinkCost { get; set; }

        [Range(0, 70, ErrorMessage = "The alcohol percentage can be in a range from 0 to 70")]
        public decimal? DrinkAlcoholPerc { get; set; }

        public byte[]? DrinkImage { get; set; }

    }
}
