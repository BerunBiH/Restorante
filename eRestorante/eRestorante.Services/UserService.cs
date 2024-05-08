using eRestorante.Services.Database;
using eRestorante.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using eRestorante.Models.Requests;
using System.Security.Cryptography;

namespace eRestorante.Services
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
        public List<eRestorante.Models.User> Get()
        {
            var entityList= _context.Users.ToList();

            return _mapper.Map<List<eRestorante.Models.User>>(entityList);
        }

        public Models.User Insert(UserInsertRequest request)
        {
            var entity = new Database.User();
            _mapper.Map(request, entity);

            entity.UserPassSalt = GenerateSalt();
            entity.UserPassHash = GenerateHash(entity.UserPassSalt, request.UserPassword);

            _context.Users.Add(entity);
            _context.SaveChanges();

            return _mapper.Map<Models.User>(entity);
        }

        public Models.User Update(int id, UserUpdateRequest request)
        {
            var entity = _context.Users.Find(id);

            _mapper.Map(request, entity);

            _context.SaveChanges();
            return _mapper.Map<Models.User>(entity);
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
            byte[] bytes= Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

    }
}
