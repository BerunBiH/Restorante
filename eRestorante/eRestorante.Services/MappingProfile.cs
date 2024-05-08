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
        }
    }
}
