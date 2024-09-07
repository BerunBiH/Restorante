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
    public class OrderDrinksController : BaseCRUDController<eRestorante.Models.Model.OrderDrinks, eRestorante.Models.SearchObjects.BaseSearchObject, OrderDrinksInsertRequest, OrderDrinksUpdateRequest>
    {

        public OrderDrinksController(ILogger<BaseController<eRestorante.Models.Model.OrderDrinks, eRestorante.Models.SearchObjects.BaseSearchObject>> logger, IOrderDrinksService service)
            :base(logger,service)
        {
        }

        [AllowAnonymous]
        public override Task<OrderDrinks> Insert([FromBody] OrderDrinksInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [AllowAnonymous]
        public override Task<OrderDrinks> Update(int id, [FromBody] OrderDrinksUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [AllowAnonymous]
        public override Task<IActionResult> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
