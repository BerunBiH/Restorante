using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class CustomerUpdateRequest
    {
        public string CustomerName { get; set; } = null!;

        public string CustomerSurname { get; set; } = null!;

        public string CustomerPhone { get; set; } = null!;

        public byte[]? CustomerImage { get; set; }

    }
}
