using eRestorante.Model;
using eRestorante.Services;
using eRestorante.Services.Database;
using Microsoft.AspNetCore.Mvc;

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
        public IEnumerable<eRestorante.Model.User> Get()
        {
            return _service.Get();
        }
    }
}
