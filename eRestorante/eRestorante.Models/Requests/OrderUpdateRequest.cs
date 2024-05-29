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
        public byte? OrderNullified { get; set; }

        public byte? OrderStatus { get; set; }
    }
}
