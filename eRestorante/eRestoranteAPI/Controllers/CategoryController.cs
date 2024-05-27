using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    public class CategoryController : BaseController<eRestorante.Models.Model.Category, eRestorante.Models.SearchObjects.CategorySearchObject>
    {
        public CategoryController(ILogger<BaseController<eRestorante.Models.Model.Category, eRestorante.Models.SearchObjects.CategorySearchObject>> logger, ICategoryService service) : base(logger, service)
        {
        }
    }
}
