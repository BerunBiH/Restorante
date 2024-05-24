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
    public class UserController : BaseCRUDController<eRestorante.Models.Model.User, eRestorante.Models.SearchObjects.UserSearchObject,UserInsertRequest,UserUpdateRequest>
    {

        public UserController(ILogger<BaseController<eRestorante.Models.Model.User, eRestorante.Models.SearchObjects.UserSearchObject>> logger, IUserService service)
            :base(logger,service)
        {
        }

        [Authorize(Roles = "Menedzer")]
        public override Task<eRestorante.Models.Model.User> Insert([FromBody] UserInsertRequest insert)
        {
            return base.Insert(insert);
        }
    }
}
