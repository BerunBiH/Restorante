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
            CreateMap<Database.Order, Order>();
            CreateMap<Database.UserRole, UserRole>();
            CreateMap<Database.Role, Role>();
            CreateMap<Database.Dish, Dishes>();
            CreateMap<Database.Drink, Drink>();
            CreateMap<Database.Customer, Customer>();
            CreateMap<Database.Category, Category>();
            CreateMap<Database.Reservation, Reservation>();
            CreateMap<Database.CommentDish, CommentDish>();
            CreateMap<Database.OrderDish, OrderDishes>();
            CreateMap<Database.OrderDrink, OrderDrinks>();
            CreateMap<Database.CommentStaff, CommentStaff>();
            CreateMap<Database.RatingStaff, RatingStaff>();
            CreateMap<Database.RatingDish, RatingDish>();
            CreateMap<Models.Requests.UserInsertRequest, Database.User>();
            CreateMap<Models.Requests.UserUpdateRequest, Database.User>();            
            CreateMap<Models.Requests.OrderInsertRequest, Database.Order>();
            CreateMap<Models.Requests.OrderUpdateRequest, Database.Order>();
            CreateMap<Models.Requests.DishInsertRequest, Database.Dish>();
            CreateMap<Models.Requests.DishUpdateRequest, Database.Dish>();
            CreateMap<Models.Requests.DrinkInsertRequest, Database.Drink>();
            CreateMap<Models.Requests.DrinkUpdateRequest, Database.Drink>();
            CreateMap<Models.Requests.CustomerInsertRequest, Database.Customer>();
            CreateMap<Models.Requests.CustomerUpdateRequest, Database.Customer>();
            CreateMap<Models.Requests.ReservationInsertRequest, Database.Reservation>();
            CreateMap<Models.Requests.ReservationUpdateRequest, Database.Reservation>();
            CreateMap<Models.Requests.CommentDishInsertRequest, Database.CommentDish>();
            CreateMap<Models.Requests.CommentStaffUpdateRequest, Database.CommentStaff>();
            CreateMap<Models.Requests.CommentStaffInsertRequest, Database.CommentStaff>();
            CreateMap<Models.Requests.RatingStaffUpdateRequest, Database.RatingStaff>();
            CreateMap<Models.Requests.RatingStaffInsertRequest, Database.RatingStaff>();
            CreateMap<Models.Requests.RatingDishUpdateRequest, Database.RatingDish>();
            CreateMap<Models.Requests.RatingDishInsertRequest, Database.RatingDish>();            
            CreateMap<Models.Requests.OrderDishesUpdateRequest, Database.OrderDish>();
            CreateMap<Models.Requests.OrderDishesInsertRequest, Database.OrderDish>();            
            CreateMap<Models.Requests.OrderDrinksUpdateRequest, Database.OrderDrink>();
            CreateMap<Models.Requests.OrderDrinksInsertRequest, Database.OrderDrink>();
        }
    }
}
