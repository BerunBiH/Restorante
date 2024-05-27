using eRestorante.Models;
using eRestorante.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Interfaces
{
    public interface IReservationService : IBaseCRUDService<Models.Model.Reservation, Models.SearchObjects.ReservationSearchObject, Models.Requests.ReservationInsertRequest, Models.Requests.ReservationUpdateRequest>
    {
    }
}
