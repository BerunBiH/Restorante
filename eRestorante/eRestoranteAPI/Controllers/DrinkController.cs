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
    public class DrinkController : BaseCRUDController<eRestorante.Models.Model.Drink, DrinkSearchObject,DrinkInsertRequest,DrinkUpdateRequest>
    {
        public DrinkController(ILogger<BaseController<eRestorante.Models.Model.Drink, DrinkSearchObject>> logger, IDrinkService service) : base(logger, service)
        {
        }

        [Authorize(Roles = "Menedzer, Šanker")]
        public override Task<eRestorante.Models.Model.Drink> Insert([FromBody] DrinkInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Menedzer, Šanker")]
        public override Task<eRestorante.Models.Model.Drink> Update(int id, [FromBody] DrinkUpdateRequest update)
        {
            return base.Update(id, update);
        }
    }
}
