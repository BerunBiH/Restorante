using eRestorante.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eRestorante.Models.Requests;

namespace eRestorante.Services.Interfaces
{
    public interface IOrderDishesService : IBaseCRUDService<Models.Model.OrderDishes, Models.SearchObjects.BaseSearchObject, OrderDishesInsertRequest, OrderDishesUpdateRequest>
    {
    }
}
