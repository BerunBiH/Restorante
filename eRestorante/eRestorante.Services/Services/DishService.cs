using eRestorante.Models.Model;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Services
{
    public class DishService : IDishesService
    {

        Ib200192Context _context;

        public DishService(Ib200192Context context)
        {
            _context = context;
        }
        List<Dishes> dishes = new List<Dishes>()
        {
            new Dishes()
            {
                DishID = 1,
                DishName="Burek",
                DishDescription="FinBurekTOp",
            }
        };
        public IList<Dish> Get()
        {
            var list = _context.Dishes.ToList();
            return list;
        }
    }
}
