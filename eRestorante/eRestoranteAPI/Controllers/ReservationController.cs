using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
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
    }
}
