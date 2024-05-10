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

namespace eRestorante.Services.Services
{
    public class UserService : IUserService
    {
        Ib200192Context _context;
        public IMapper _mapper { get; set; }

        public UserService(Ib200192Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task<List<Models.Model.User>> Get()
        {
            var entityList = await _context.Users.ToListAsync();

            return _mapper.Map<List<Models.Model.User>>(entityList);
        }

        public Models.Model.User Insert(UserInsertRequest request)
        {
            var entity = new Database.User();
            _mapper.Map(request, entity);

            entity.UserPassSalt = GenerateSalt();
            entity.UserPassHash = GenerateHash(entity.UserPassSalt, request.UserPassword);

            _context.Users.Add(entity);
            _context.SaveChanges();

            return _mapper.Map<Models.Model.User>(entity);
        }

        public Models.Model.User Update(int id, UserUpdateRequest request)
        {
            var entity = _context.Users.Find(id);

            _mapper.Map(request, entity);

            _context.SaveChanges();
            return _mapper.Map<Models.Model.User>(entity);
        }

        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);

            return Convert.ToBase64String(byteArray);
        }

        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
    }
}
