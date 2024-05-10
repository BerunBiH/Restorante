using AutoMapper;
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
    public class DrinkService : BaseService<Models.Model.Drink, Database.Drink>, IDrinkService
    {
        Ib200192Context _context;
        public IMapper _mapper;

        public DrinkService(Ib200192Context context, IMapper mapper)
            : base(context, mapper)
        {

        }

    }
}
