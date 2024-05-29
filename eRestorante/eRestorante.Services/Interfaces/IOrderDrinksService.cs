using eRestorante.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eRestorante.Models.Requests;

namespace eRestorante.Services.Interfaces
{
    public interface IOrderDrinksService : IBaseCRUDService<Models.Model.OrderDrinks, Models.SearchObjects.BaseSearchObject, OrderDrinksInsertRequest, OrderDrinksUpdateRequest>
    {
    }
}
