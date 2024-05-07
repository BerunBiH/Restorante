using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class CommentStaff
{
    public int CommentStaffId { get; set; }

    public DateOnly CommentDate { get; set; }

    public string CommentText { get; set; } = null!;

    public int? CustomerId { get; set; }

    public int? UserId { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual User? User { get; set; }
}
