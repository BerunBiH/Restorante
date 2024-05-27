using AutoMapper;
using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Services
{
    public class DrinkService : BaseCRUDService<Models.Model.Drink, Database.Drink, DrinkSearchObject, DrinkInsertRequest,DrinkUpdateRequest>, IDrinkService
    {
        public DrinkService(Ib200192Context context, IMapper mapper)
            : base(context, mapper)
        {

        }

    }
}
