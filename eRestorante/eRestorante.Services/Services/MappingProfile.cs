using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using eRestorante.Models.Model;

namespace eRestorante.Services.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.User, User>();
            CreateMap<Database.UserRole, UserRole>();
            CreateMap<Database.Role, Role>();
            CreateMap<Database.Dish, Dishes>();
            CreateMap<Database.Drink, Drink>();
            CreateMap<Database.Customer, Customer>();
            CreateMap<Models.Requests.UserInsertRequest, Database.User>();
            CreateMap<Models.Requests.UserUpdateRequest, Database.User>();
            CreateMap<Models.Requests.DishInsertRequest, Database.Dish>();
            CreateMap<Models.Requests.DishUpdateRequest, Database.Dish>();
            CreateMap<Models.Requests.DrinkInsertRequest, Database.Drink>();
            CreateMap<Models.Requests.DrinkUpdateRequest, Database.Drink>();
            CreateMap<Models.Requests.CustomerInsertRequest, Database.Customer>();
            CreateMap<Models.Requests.CustomerUpdateRequest, Database.Customer>();
        }
    }
}
