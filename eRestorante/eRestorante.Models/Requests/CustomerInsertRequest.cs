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

        public string CustomerName { get; set; } = null!;

        public string CustomerSurname { get; set; } = null!;

        public string CustomerEmail { get; set; } = null!;

        public string CustomerPhone { get; set; } = null!;

        [Compare("CustomerPasswordRepeat", ErrorMessage = "Passwords do not match")]
        public string CustomerPassword { get; set; } = null!;

        [Compare("CustomerPassword", ErrorMessage = "Passwords do not match")]
        public string CustomerPasswordRepeat { get; set; } = null!;

        public byte[]? CustomerImage { get; set; }

    }
}
