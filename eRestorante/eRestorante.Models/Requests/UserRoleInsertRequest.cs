using eRestorante.Models.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class UserRoleInsertRequest
    {

        public int UserId { get; set; }

        public int RoleId { get; set; }

        public DateOnly DateChange { get; set; }

    }
}
