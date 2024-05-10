using AutoMapper;
using eRestorante.Models;
using eRestorante.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services
{
    public class DrinkService : IDrinkService
    {
        Ib200192Context _context;
        public IMapper _mapper;

        public DrinkService(Ib200192Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task<List<Models.Drink>> Get()
        {
            var entityList = await _context.Drinks.ToListAsync();

            return _mapper.Map<List<Models.Drink>>(entityList);
        }
    }
}
