using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    public class RatingStaffController : BaseCRUDController<eRestorante.Models.Model.RatingStaff, eRestorante.Models.SearchObjects.RatingStaffSearchObject, RatingStaffInsertRequest, RatingStaffUpdateRequest>
    {
        public RatingStaffController(ILogger<BaseController<eRestorante.Models.Model.RatingStaff, eRestorante.Models.SearchObjects.RatingStaffSearchObject>> logger, IRatingStaffService service) : base(logger, service)
        {
        }
    }
}
