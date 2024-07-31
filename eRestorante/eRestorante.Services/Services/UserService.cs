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
    public class UserService : BaseCRUDService<Models.Model.User, Database.User, Models.SearchObjects.UserSearchObject, UserInsertRequest, UserUpdateRequest>, IUserService
    {

        public UserService(Ib200192Context context, IMapper mapper)
            :base(context,mapper)
        {
        }

        public override IQueryable<User> AddFilter(IQueryable<User> query, UserSearchObject? search = null)
        {
            
            if (!string.IsNullOrWhiteSpace(search?.UserFTS))
            {
                query = query.Where(x => x.UserName.Contains(search.UserFTS) || x.UserSurname.Contains(search.UserFTS));
            }

            return base.AddFilter(query, search);
        }

        public override async Task<Models.Model.User> Insert(UserInsertRequest insert)
        {
            return await base.Insert(insert);
        }

        public override async Task BeforeInsert(User entity, UserInsertRequest request)
        {
            entity.UserPassSalt = GenerateSalt();
            entity.UserPassHash = GenerateHash(entity.UserPassSalt, request.UserPassword);
        }

        public override async Task<Models.Model.User> Update(int id, UserUpdateRequest update)
        {
            return await base.Update(id, update);
        }

        public override IQueryable<User> AddInclude(IQueryable<User> query, UserSearchObject? search = null)
        {

            //if (search?.isRoleIncluded==true)
            //{
                query = query.Include("UserRoles.Role");
            //}
            return base.AddInclude(query,search);
        }

        public async Task<Models.Model.User> Login(string email, string password)
        {
            var entity = await _context.Users.Include("UserRoles.Role").FirstOrDefaultAsync(x => x.UserEmail == email);

            if (entity == null)
                return null;

            var hash = GenerateHash(entity.UserPassSalt, password);

            if (hash != entity.UserPassHash)
            {
                return null;
            }

            return _mapper.Map<Models.Model.User>(entity);

        }
    }
}
