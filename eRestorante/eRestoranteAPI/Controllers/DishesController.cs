using eRestorante.Model;
using eRestorante.Services;
using Microsoft.AspNetCore.Mvc;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DishesController : ControllerBase
    {
        private readonly IDishesService _dishesService;
        //private readonly ILogger<WeatherForecastController> _logger;

        public DishesController(IDishesService dishesService)
        {
            //_logger = logger;
            _dishesService = dishesService;
        }

        [HttpGet()]
        public IEnumerable<Dishes> Get()
        {
            return _dishesService.Get();
        }
    }
}
