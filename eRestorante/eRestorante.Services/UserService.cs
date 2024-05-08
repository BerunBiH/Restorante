using eRestorante.Services.Database;
using eRestorante.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eRestorante.Models;

namespace eRestorante.Services
{
    public class UserService : IUserService
    {
        Ib200192Context _context;

        public UserService(Ib200192Context context)
        {
            _context = context;
        }
        public List<Model.User> Get()
        {
            var entityList= _context.Users.ToList();

            var list = new List<Model.User>();
            foreach (var user in entityList)
            {
                list.Add(new Model.User()
                {
                    Email=user.UserEmail,
                    UserName=user.UserName,
                    UserSurname=user.UserSurname,
                    UserPhone = user.UserPhone,
                    UserStatus=user.UserStatus,
                    UserImage = user.UserImage,
                    UserId = user.UserId
                });
            }
            return list;
        }
    }
}
