using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class RatingStaff
{
    public int RatingStaffId { get; set; }

    public int RatingNumber { get; set; }

    public DateOnly RatingDate { get; set; }

    public int? CustomerId { get; set; }

    public int? UserId { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual User? User { get; set; }
}
