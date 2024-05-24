﻿using eRestorante.Services.Database;
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

            if (search?.isRoleIncluded==true)
            {
                query = query.Include("UserRoles.Role");
            }
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

        public static string GenerateSalt()
        {
            int saltSize = 16;

            byte[] saltBytes = new byte[saltSize];

            using (var rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(saltBytes);
            }

            return Convert.ToBase64String(saltBytes);
        }

        public static string GenerateHash(string salt, string password)
        {
            string saltedPassword = salt + password;

            using (var sha256 = SHA256.Create())
            {
                byte[] saltedPasswordBytes = Encoding.UTF8.GetBytes(saltedPassword);
                byte[] hashBytes = sha256.ComputeHash(saltedPasswordBytes);

                // Convert the hash byte array to a base64 string
                return Convert.ToBase64String(hashBytes);
            }
        }
    }
}
