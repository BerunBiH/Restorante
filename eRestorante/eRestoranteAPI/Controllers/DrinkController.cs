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
    public class DrinkController : ControllerBase
    {
        private readonly IDrinkService _service;
        //private readonly ILogger<WeatherForecastController> _logger;

        public DrinkController(IDrinkService service)
        {
            //_logger = logger;
            _service = service;
        }

        [HttpGet()]
        public async Task<IEnumerable<eRestorante.Models.Drink>> Get()
        {
            return await _service.Get();
        }

        //[HttpPost()]
        //public eRestorante.Models.User Insert(UserInsertRequest request)
        //{
        //    return _service.Insert(request);
        //}

        //[HttpPut("{id}")]
        //public eRestorante.Models.User Update(int id, UserUpdateRequest request) 
        //{
        //    return _service.Update(id, request);
        //}
    }
}
