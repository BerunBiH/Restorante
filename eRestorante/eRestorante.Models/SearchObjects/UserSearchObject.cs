using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.SearchObjects
{
    public class UserSearchObject:BaseSearchObject
    {
        public bool? isRoleIncluded { get; set; }
    }
}
