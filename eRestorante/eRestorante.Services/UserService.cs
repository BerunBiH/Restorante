using eRestorante.Services.Database;
using eRestorante.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;

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
    }
}
