using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class BaseController<T> : ControllerBase where T : class
    {
        private readonly IService<T> _service;
        private readonly ILogger<BaseController<T>> _logger;

        public BaseController(ILogger<BaseController<T>> logger,IService<T> service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpGet()]
        public async Task<IEnumerable<T>> Get()
        {
            return await _service.Get();
        }
    }
}
