using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class Role
{
    public int RolesId { get; set; }

    public string RoleName { get; set; } = null!;

    public string? RoleDescription { get; set; }

    public virtual ICollection<UserRole> UserRoles { get; set; } = new List<UserRole>();
}
