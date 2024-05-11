using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.SearchObjects
{
    public class CustomerSearchObject : BaseSearchObject
    {
        public string? CustomerName { get; set; }
        public string? CustomerFTS { get; set; }
    }
}
