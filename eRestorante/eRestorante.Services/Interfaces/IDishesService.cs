﻿using eRestorante.Models;
using eRestorante.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Interfaces
{
    public interface IDishesService : IBaseCRUDService<Models.Model.Dishes, Models.SearchObjects.DishSearchObject, Models.Requests.DishInsertRequest, Models.Requests.DishUpdateRequest>
    {
        List<Models.Model.Dishes> Recommended(int id);
    }
}
