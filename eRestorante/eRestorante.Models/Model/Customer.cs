using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Model
{
    public partial class Customer
    {
        public int CustomerId { get; set; }

        public string CustomerName { get; set; } = null!;

        public string CustomerSurname { get; set; } = null!;

        public string CustomerEmail { get; set; } = null!;

        public string CustomerPhone { get; set; } = null!;

        public DateOnly CustomerDateRegister { get; set; }

        public byte[]? CustomerImage { get; set; }

        public byte? CustomerStatus { get; set; }
    }
}
