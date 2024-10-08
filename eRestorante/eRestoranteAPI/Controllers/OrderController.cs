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
    public class OrderController : BaseCRUDController<eRestorante.Models.Model.Order, eRestorante.Models.SearchObjects.OrderSearchObject, OrderInsertRequest, OrderUpdateRequest>
    {

        public OrderController(ILogger<BaseController<eRestorante.Models.Model.Order, eRestorante.Models.SearchObjects.OrderSearchObject>> logger, IOrderService service)
            :base(logger,service)
        {
        }

        [Authorize]
        public override async Task<eRestorante.Models.Model.Order> Insert([FromBody] OrderInsertRequest insert)
        {
            return await _service.Insert(insert);
        }

        [Authorize]
        public override Task<eRestorante.Models.Model.Order> Update(int id, [FromBody] OrderUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize]
        public override Task<IActionResult> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
