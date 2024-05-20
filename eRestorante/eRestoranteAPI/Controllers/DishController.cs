using eRestorante.Models.Requests;
using eRestorante.Models.Model;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;

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
    }
}
