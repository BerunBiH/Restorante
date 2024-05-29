using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class CustomerInsertRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage ="This field can not be empty.")]
        [MinLength(2,ErrorMessage ="The customer name can't be less than 2 characters.")]
        [MaxLength(50, ErrorMessage = "The customer name can't be more than 50 characters.")]
        public string CustomerName { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [MinLength(2, ErrorMessage = "The customer surname can't be less than 2 characters.")]
        [MaxLength(50, ErrorMessage = "The customer surname can't be more than 50 characters.")]
        public string CustomerSurname { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [EmailAddress(ErrorMessage ="The email needs to be in a valid format")]
        public string CustomerEmail { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [Phone(ErrorMessage = "The phone needs to be in a valid format")]
        public string CustomerPhone { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [Compare("CustomerPasswordRepeat", ErrorMessage = "Passwords do not match")]
        public string CustomerPassword { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [Compare("CustomerPassword", ErrorMessage = "Passwords do not match")]
        public string CustomerPasswordRepeat { get; set; } = null!;

        public byte[]? CustomerImage { get; set; }

    }
}
