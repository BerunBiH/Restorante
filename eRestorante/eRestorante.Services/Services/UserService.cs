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
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

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
            query = query.Include("UserRoles.Role");
            query = query.Include("CommentStaffs.Customer");
            query = query.Include("RatingStaffs");

            return base.AddInclude(query,search);
        }

        public override async Task<User> AddIncludeId(IQueryable<User> query, int id)
        {
            query = query.Include("UserRoles.Role");
            query = query.Include("CommentStaffs.Customer");
            query = query.Include("RatingStaffs");
            var entity = await query.FirstOrDefaultAsync(x => x.UserId == id);
            return entity;
        }

        public override async Task<Task> BeforeRemove(User db)
        {

            var entityRole = await _context.UserRoles.FirstOrDefaultAsync(x => x.UserId==db.UserId);

            if (entityRole != null)
            {
                _context.UserRoles.Remove(entityRole);

                await _context.SaveChangesAsync();
            }

            var entityRating = await _context.RatingStaffs.Where(x => x.UserId == db.UserId).ToListAsync();

            foreach (var rating in entityRating)
            {
                _context.RatingStaffs.Remove(rating);

                await _context.SaveChangesAsync();
            }

            var entityComment = await _context.CommentStaffs.Where(x => x.UserId == db.UserId).ToListAsync();

            foreach (var comment in entityComment)
            {
                _context.CommentStaffs.Remove(comment);

                await _context.SaveChangesAsync();
            }

            return base.BeforeRemove(db);
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
