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
    public class UserRoleController : BaseCRUDController<eRestorante.Models.Model.UserRole, eRestorante.Models.SearchObjects.UserRoleSearchObject,UserRoleInsertRequest,UserRoleUpdateRequest>
    {

        public UserRoleController(ILogger<BaseController<eRestorante.Models.Model.UserRole, eRestorante.Models.SearchObjects.UserRoleSearchObject>> logger, IUserRoleService service)
            :base(logger,service)
        {
        }

        [Authorize(Roles = "Menedzer")]
        public override Task<eRestorante.Models.Model.UserRole> Insert([FromBody] UserRoleInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Menedzer")]
        public override Task<eRestorante.Models.Model.UserRole> Update(int id, [FromBody] UserRoleUpdateRequest update)
        {
            return base.Update(id, update);
        }
    }
}
