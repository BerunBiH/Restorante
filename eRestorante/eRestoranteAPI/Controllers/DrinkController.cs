using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    public class DrinkController : BaseController<eRestorante.Models.Model.Drink, BaseSearchObject>
    {
        public DrinkController(ILogger<BaseController<eRestorante.Models.Model.Drink, BaseSearchObject>> logger, IDrinkService service) : base(logger, service)
        {
        }
    }
}
