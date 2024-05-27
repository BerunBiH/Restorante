using AutoMapper;
using eRestorante.Models.Exceptions;
using eRestorante.Models.Model;
using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Services
{
    public class ReservationService : BaseCRUDService<Models.Model.Reservation, Database.Reservation, Models.SearchObjects.ReservationSearchObject, Models.Requests.ReservationInsertRequest, Models.Requests.ReservationUpdateRequest>, IReservationService
    {
        public ReservationService(Ib200192Context context, IMapper mapper)
            :base(context, mapper)
        {  
        }
    }
}
