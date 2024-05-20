using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Model
{
    public partial class Role
    {
        public int RolesId { get; set; }

        public string RoleName { get; set; } = null!;

        public string? RoleDescription { get; set; }

    }
}
