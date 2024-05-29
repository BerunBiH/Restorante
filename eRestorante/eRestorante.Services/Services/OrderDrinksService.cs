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
    public class OrderDrinksService : BaseCRUDService<Models.Model.OrderDrinks, Database.OrderDrink, Models.SearchObjects.BaseSearchObject, OrderDrinksInsertRequest, OrderDrinksUpdateRequest>, IOrderDrinksService
    {

        public OrderDrinksService(Ib200192Context context, IMapper mapper)
            :base(context,mapper)
        {
        }
    }
}
