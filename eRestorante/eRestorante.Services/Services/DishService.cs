﻿using AutoMapper;
using eRestorante.Models.Model;
using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Services
{
    public class DishService : BaseCRUDService<Models.Model.Dishes, Database.Dish, Models.SearchObjects.DishSearchObject, Models.Requests.DishInsertRequest, Models.Requests.DishUpdateRequest>, IDishesService
    {
        public DishService(Ib200192Context context, IMapper mapper)
            :base(context, mapper)
        {  
        }
    }
}
