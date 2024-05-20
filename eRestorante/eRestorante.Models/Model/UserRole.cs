using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Model
{
    public partial class UserRole
    {
        public int UserRolesId { get; set; }

        public int? UserId { get; set; }

        public int? RoleId { get; set; }

        public DateOnly DateChange { get; set; }

        public virtual Role? Role { get; set; }

    }
}
