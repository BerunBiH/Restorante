using eRestorante.Models.Model;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class BaseController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        protected readonly IService<T, TSearch> _service;
        protected readonly ILogger<BaseController<T, TSearch>> _logger;

        public BaseController(ILogger<BaseController<T, TSearch>> logger,IService<T, TSearch> service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpGet()]
        public async Task<PageResult<T>> Get([FromQuery]TSearch? search=null)
        {
            return await _service.Get(search);
        }

        [HttpGet("{id}")]
        public async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }
    }
}
