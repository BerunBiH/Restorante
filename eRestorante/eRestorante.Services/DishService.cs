using eRestorante.Models;
using eRestorante.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services
{
    public class DishService : IDishesService
    {

        Ib200192Context _context;

        public DishService(Ib200192Context context)
        {
            _context = context;
        }
        List<Models.Dishes> dishes = new List<Dishes>()
        {
            new Models.Dishes()
            {
                DishID = 1,
                DishName="Burek",
                DishDescription="FinBurekTOp",
            }
        };
        public IList<Dish> Get()
        {
            var list =_context.Dishes.ToList();
            return list;
        }
    }
}
