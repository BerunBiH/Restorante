using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class ReservationUpdateRequest
    {

        public DateOnly ReservationDate { get; set; }

        public TimeOnly ReservationTime { get; set; }

        public int NumberOfGuests { get; set; }

        public int NumberOfHours { get; set; }

        public string? ReservationReason { get; set; }

        public int? NumberOfMinors { get; set; }

        public string ContactPhone { get; set; } = null!;

        public string SpecialWishes { get; set; } = null!;

    }
}
