using eRestorante.Models.Model;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class BaseCRUDController<T, TSearch, TInsert, Tupdate> : BaseController<T, TSearch> where T : class where TSearch : class where TInsert : class where Tupdate : class
    {
        protected new readonly IBaseCRUDService<T, TSearch, TInsert, Tupdate> _service;
        protected readonly ILogger<BaseController<T, TSearch>> _logger;

        public BaseCRUDController(ILogger<BaseController<T, TSearch>> logger, IBaseCRUDService<T, TSearch, TInsert, Tupdate> service)
            :base(logger,service)
        {
            _service = service;
            _logger = logger;
        }

        [HttpPost()]
        public virtual async Task<T> Insert([FromBody]TInsert insert)
        {
            return await _service.Insert(insert);
        }

        [HttpPut("{id}")]
        public virtual async Task<T> Update(int id, [FromBody]Tupdate update)
        {
            return await _service.Update(id, update);
        }
    }
}
