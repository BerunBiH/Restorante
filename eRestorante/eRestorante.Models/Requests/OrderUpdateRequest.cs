using eRestorante.Models.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class OrderUpdateRequest
    {
        [Range(0, 1, ErrorMessage = "This field can have a value from 0 to 1")]
        public byte? OrderNullified { get; set; }

        [Range(0, 3, ErrorMessage = "This field can have a value from 0 to 3")]
        public byte? OrderStatus { get; set; }
    }
}
