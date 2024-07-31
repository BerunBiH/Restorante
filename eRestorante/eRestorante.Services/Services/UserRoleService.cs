using eRestorante.Services.Database;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using eRestorante.Models.Requests;
using System.Security.Cryptography;
using Microsoft.EntityFrameworkCore;
using eRestorante.Services.Interfaces;
using eRestorante.Models.SearchObjects;

namespace eRestorante.Services.Services
{
    public class UserRoleService : BaseCRUDService<Models.Model.UserRole, Database.UserRole, Models.SearchObjects.UserRoleSearchObject, UserRoleInsertRequest, UserRoleUpdateRequest>, IUserRoleService
    {

        public UserRoleService(Ib200192Context context, IMapper mapper)
            :base(context,mapper)
        {
        }

        public override IQueryable<UserRole> AddFilter(IQueryable<UserRole> query, UserRoleSearchObject? search = null)
        {
            if (search!=null)
            {
                query = query.Where(x => x.UserId==search.UserId);
            }
            return base.AddFilter(query, search);
        }
    }
}
