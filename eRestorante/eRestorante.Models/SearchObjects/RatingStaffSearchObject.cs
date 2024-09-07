using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.SearchObjects
{
    public class RatingStaffSearchObject : BaseSearchObject
    {
        public int? RatingNumber { get; set; }

        public int? CustomerId { get; set; }
    }
}
