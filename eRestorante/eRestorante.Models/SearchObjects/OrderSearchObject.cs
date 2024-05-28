using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.SearchObjects
{
    public class OrderSearchObject:BaseSearchObject
    {
        public int OrderNumber { get; set; }

        public DateOnly OrderDate { get; set; }

        public int? CustomerId { get; set; }
    }
}
