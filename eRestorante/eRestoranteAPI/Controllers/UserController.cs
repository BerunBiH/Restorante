using eRestorante.Models;
using eRestorante.Models.Requests;
using eRestorante.Services;
using eRestorante.Services.Database;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IUserService _service;
        //private readonly ILogger<WeatherForecastController> _logger;

        public UserController(IUserService service)
        {
            //_logger = logger;
            _service = service;
        }

        [HttpGet()]
        public IEnumerable<eRestorante.Models.User> Get()
        {
            return _service.Get();
        }

        [HttpPost()]
        public eRestorante.Models.User Insert(UserInsertRequest request)
        {
            return _service.Insert(request);
        }

        [HttpPut("{id}")]
        public eRestorante.Models.User Update(int id, UserUpdateRequest request) 
        {
            return _service.Update(id, request);
        }
    }
}
