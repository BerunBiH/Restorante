using AutoMapper;
using eRestorante.Models.Exceptions;
using eRestorante.Models.Model;
using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Services
{
    public class ReservationService : BaseCRUDService<Models.Model.Reservation, Database.Reservation, Models.SearchObjects.ReservationSearchObject, Models.Requests.ReservationInsertRequest, Models.Requests.ReservationUpdateRequest>, IReservationService
    {
        private readonly EmailService _emailService;

        public ReservationService(Ib200192Context context, IMapper mapper, EmailService emailService)
            : base(context, mapper)
        {
            _emailService = emailService;
        }

        public override async Task BeforeInsert(Database.Reservation db, ReservationInsertRequest insert)
        {
            var customer = await _context.Customers.FirstOrDefaultAsync(x=>x.CustomerId==db.CustomerId);

            var userEmail = customer.CustomerEmail;
            if (!string.IsNullOrEmpty(userEmail))
            {
                _emailService.SendEmail(userEmail, "Your reservation has been successfully created. Thank you");
            }
            await base.BeforeInsert(db, insert);
        }
    }
}
