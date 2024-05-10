using eRestorante.Models.Requests;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    public class DrinkController : BaseController<eRestorante.Models.Model.Drink>
    {
        public DrinkController(ILogger<BaseController<eRestorante.Models.Model.Drink>> logger, IDrinkService service) : base(logger, service)
        {
        }
    }
}
