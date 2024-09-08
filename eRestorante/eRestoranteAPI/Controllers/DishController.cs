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
    public class DishController : BaseCRUDController<eRestorante.Models.Model.Dishes, eRestorante.Models.SearchObjects.DishSearchObject,DishInsertRequest,DishUpdateRequest>
    {

        public DishController(ILogger<BaseController<eRestorante.Models.Model.Dishes, eRestorante.Models.SearchObjects.DishSearchObject>> logger, IDishesService service)
            :base(logger,service)
        {
        }
        [Authorize(Roles = "Menedzer, Kuhar")]
        public override Task<Dishes> Insert([FromBody] DishInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Menedzer, Kuhar")]
        public override Task<Dishes> Update(int id, [FromBody] DishUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize]
        [HttpGet("{id}/recommend")]
        public List<eRestorante.Models.Model.Dishes> Recommend(int id)
        {
            return (_service as IDishesService).Recommended(id);
        }
    }
}
