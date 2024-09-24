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
    public class ReservationController : BaseCRUDController<eRestorante.Models.Model.Reservation, eRestorante.Models.SearchObjects.ReservationSearchObject, ReservationInsertRequest, ReservationUpdateRequest>
    {
        public ReservationController(ILogger<BaseController<eRestorante.Models.Model.Reservation, eRestorante.Models.SearchObjects.ReservationSearchObject>> logger, IReservationService service) : base(logger, service)
        {
        }

        [Authorize]
        public override Task<eRestorante.Models.Model.Reservation> Insert([FromBody] ReservationInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize]
        public override Task<eRestorante.Models.Model.Reservation> Update(int id, [FromBody] ReservationUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize]
        public override Task<IActionResult> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
