using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
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
    }
}
