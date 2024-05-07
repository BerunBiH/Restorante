using eRestorante.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services
{
    public class DishService : IDishesService
    {
        List<Dishes> dishes = new List<Dishes>()
        {
            new Dishes()
            {
                DishID = 1,
                DishName="Burek",
                DishDescription="FinBurekTOp",
            }
        };
        public IList<Dishes> Get()
        {
            return dishes;
        }
    }
}
