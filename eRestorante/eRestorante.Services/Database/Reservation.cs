using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class Reservation
{
    public int ReservationId { get; set; }

    public DateOnly ReservationDate { get; set; }

    public TimeOnly ReservationTime { get; set; }

    public int NumberOfGuests { get; set; }

    public int NumberOfHours { get; set; }

    public int ReservationStatus { get; set; }

    public int? CustomerId { get; set; }

    public string? ReservationReason { get; set; }

    public int? NumberOfMinors { get; set; }

    public string ContactPhone { get; set; } = null!;

    public string SpecialWishes { get; set; } = null!;

    public virtual Customer? Customer { get; set; }
}
