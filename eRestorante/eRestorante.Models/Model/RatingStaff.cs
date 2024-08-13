using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Model
{
    public partial class RatingStaff
    {
        public int RatingStaffId { get; set; }

        public int RatingNumber { get; set; }

        public DateOnly RatingDate { get; set; }

        public int? CustomerId { get; set; }

        public int? UserId { get; set; }

    }
}
