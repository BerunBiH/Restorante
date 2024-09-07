using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    public class RatingDishController : BaseCRUDController<eRestorante.Models.Model.RatingDish, eRestorante.Models.SearchObjects.RatingDishSearchObject, RatingDishInsertRequest, RatingDishUpdateRequest>
    {
        public RatingDishController(ILogger<BaseController<eRestorante.Models.Model.RatingDish, eRestorante.Models.SearchObjects.RatingDishSearchObject>> logger, IRatingDishService service) : base(logger, service)
        {
        }

        [AllowAnonymous]
        public override Task<eRestorante.Models.Model.RatingDish> Insert([FromBody] RatingDishInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [AllowAnonymous]
        public override Task<eRestorante.Models.Model.RatingDish> Update(int id, [FromBody] RatingDishUpdateRequest update)
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
