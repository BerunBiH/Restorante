using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    public class CustomerController : BaseCRUDController<eRestorante.Models.Model.Customer, eRestorante.Models.SearchObjects.CustomerSearchObject, CustomerInsertRequest, CustomerUpdateRequest>
    {
        public CustomerController(ILogger<BaseController<eRestorante.Models.Model.Customer, eRestorante.Models.SearchObjects.CustomerSearchObject>> logger, ICustomerService service) : base(logger, service)
        {
        }

        [Authorize]
        public override Task<eRestorante.Models.Model.Customer> Insert([FromBody] CustomerInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize]
        public override Task<eRestorante.Models.Model.Customer> Update(int id, [FromBody] CustomerUpdateRequest update)
        {
            return base.Update(id, update);
        }
    }
}
