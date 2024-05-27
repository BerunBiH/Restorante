using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    public class RoleController : BaseController<eRestorante.Models.Model.Role, eRestorante.Models.SearchObjects.RoleSearchObject>
    {
        public RoleController(ILogger<BaseController<eRestorante.Models.Model.Role, eRestorante.Models.SearchObjects.RoleSearchObject>> logger, IRoleService service) : base(logger, service)
        {
        }
    }
}
