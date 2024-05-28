using eRestorante.Models.Requests;
using eRestorante.Models.Model;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.AspNetCore.Authorization;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class OrderDishesController : BaseCRUDController<eRestorante.Models.Model.OrderDishes, eRestorante.Models.SearchObjects.BaseSearchObject, OrderDishesInsertRequest, OrderDishesUpdateRequest>
    {

        public OrderDishesController(ILogger<BaseController<eRestorante.Models.Model.OrderDishes, eRestorante.Models.SearchObjects.BaseSearchObject>> logger, IOrderDishesService service)
            :base(logger,service)
        {
        }
    }
}
