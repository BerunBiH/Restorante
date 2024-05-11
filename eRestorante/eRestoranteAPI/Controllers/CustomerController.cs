using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    public class CustomerController : BaseController<eRestorante.Models.Model.Customer, eRestorante.Models.SearchObjects.CustomerSearchObject>
    {
        public CustomerController(ILogger<BaseController<eRestorante.Models.Model.Customer, eRestorante.Models.SearchObjects.CustomerSearchObject>> logger, ICustomerService service) : base(logger, service)
        {
        }
    }
}
