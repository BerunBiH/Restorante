using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class UserInsertRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [MinLength(2, ErrorMessage = "The user name can't be less than 2 characters.")]
        [MaxLength(50, ErrorMessage = "The user name can't be more than 50 characters.")]
        public string UserName { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [MinLength(2, ErrorMessage = "The user surname can't be less than 2 characters.")]
        [MaxLength(50, ErrorMessage = "The user surname can't be more than 50 characters.")]
        public string UserSurname { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [EmailAddress(ErrorMessage = "The email needs to be in a valid format")]
        public string UserEmail { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [Phone(ErrorMessage = "The phone needs to be in a valid format")]
        public string UserPhone { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [Compare("UserPasswordRepeat", ErrorMessage = "Passwords do not match")]
        public string UserPassword { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [Compare("UserPassword", ErrorMessage = "Passwords do not match")]
        public string UserPasswordRepeat { get; set; } = null!;

        [Range(0, 1, ErrorMessage = "This field can have a value from 0 to 1")]
        public byte? UserStatus { get; set; }

        public byte[]? UserImage { get; set; }
    }
}
