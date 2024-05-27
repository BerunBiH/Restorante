using AutoMapper;
using eRestorante.Models.Exceptions;
using eRestorante.Models.Model;
using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Services
{
    public class RoleService : BaseService<Models.Model.Role, Database.Role, Models.SearchObjects.RoleSearchObject>, IRoleService
    {
        public RoleService(Ib200192Context context, IMapper mapper)
            :base(context, mapper)
        {  
        }

        public override IQueryable<Database.Role> AddFilter(IQueryable<Database.Role> query, RoleSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.RoleName))
            {
                query = query.Where(x => x.RoleName.StartsWith(search.RoleName));
            }
            return base.AddFilter(query, search);
        }
    }
}
