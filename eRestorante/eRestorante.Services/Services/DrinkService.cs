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

        public override IQueryable<Drink> AddFilter(IQueryable<Drink> query, DrinkSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.DrinkName))
            {
                query = query.Where(x => x.DrinkName.Contains(search.DrinkName));
            }

            return base.AddFilter(query, search);
        }

        public override async Task<Task> BeforeRemove(Drink db)
        {

            var entityOrderD = await _context.OrderDrinks.Where(x => x.DrinkId == db.DrinkId).ToListAsync();

            foreach (var orderD in entityOrderD)
            {
                _context.OrderDrinks.Remove(orderD);

                await _context.SaveChangesAsync();
            }

            return base.BeforeRemove(db);
        }

    }
}
