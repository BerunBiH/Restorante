using eRestorante.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eRestorante.Models.Requests;

namespace eRestorante.Services.Interfaces
{
    public interface IOrderService : IBaseCRUDService<Models.Model.Order, Models.SearchObjects.OrderSearchObject,OrderInsertRequest,OrderUpdateRequest>
    {
    }
}
