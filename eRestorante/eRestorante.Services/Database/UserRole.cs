using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class UserRole
{
    public int UserRolesId { get; set; }

    public int? UserId { get; set; }

    public int? RoleId { get; set; }

    public DateOnly DateChange { get; set; }

    public virtual Role? Role { get; set; }

    public virtual User? User { get; set; }
}
