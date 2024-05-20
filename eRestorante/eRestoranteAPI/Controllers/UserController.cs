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
    public class UserController : BaseController<eRestorante.Models.Model.User, eRestorante.Models.SearchObjects.UserSearchObject>
    {

        public UserController(ILogger<BaseController<eRestorante.Models.Model.User, eRestorante.Models.SearchObjects.UserSearchObject>> logger, IUserService service)
            :base(logger,service)
        {
        }

        [HttpPost()]
        public eRestorante.Models.Model.User Insert(UserInsertRequest request)
        {
            return (_service as IUserService).Insert(request);
        }

        [HttpPut("{id}")]
        public eRestorante.Models.Model.User Update(int id, UserUpdateRequest request) 
        {
            return (_service as IUserService).Update(id, request);
        }
    }
}
