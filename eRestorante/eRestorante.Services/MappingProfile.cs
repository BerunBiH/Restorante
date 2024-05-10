using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;

namespace eRestorante.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile() { 
            CreateMap<Database.User, eRestorante.Models.User>();
            CreateMap<Database.Drink, eRestorante.Models.Drink>();
            CreateMap<Models.Requests.UserInsertRequest, Database.User > ();
            CreateMap<Models.Requests.UserUpdateRequest, Database.User > ();
        }
    }
}
