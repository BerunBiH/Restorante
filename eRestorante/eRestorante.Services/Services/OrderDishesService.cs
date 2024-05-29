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
using eRestorante.Models.Model;

namespace eRestorante.Services.Services
{
    public class OrderDishesService : BaseCRUDService<Models.Model.OrderDishes, Database.OrderDish, Models.SearchObjects.BaseSearchObject, OrderDishesInsertRequest, OrderDishesUpdateRequest>, IOrderDishesService
    {

        public OrderDishesService(Ib200192Context context, IMapper mapper)
            :base(context,mapper)
        {
        }
    }
}
