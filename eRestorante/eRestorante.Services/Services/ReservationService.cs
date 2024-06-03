using AutoMapper;
using eRestorante.Models.Exceptions;
using eRestorante.Models.Model;
using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Services
{
    public class ReservationService : BaseCRUDService<Models.Model.Reservation, Database.Reservation, Models.SearchObjects.ReservationSearchObject, Models.Requests.ReservationInsertRequest, Models.Requests.ReservationUpdateRequest>, IReservationService
    {
        private readonly RabbitMQ.Client.IModel _channel;

        public ReservationService(Ib200192Context context, IMapper mapper, ConnectionFactory factory)
            : base(context, mapper)
        {
            var connection = factory.CreateConnection();
            _channel = connection.CreateModel();
            _channel.QueueDeclare(queue: "reservationQueue",
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: false,
                                 arguments: null);
        }

        public override async Task BeforeInsert(Database.Reservation db, ReservationInsertRequest insert)
        {
            var customer = await _context.Customers.FirstOrDefaultAsync(x=>x.CustomerId==db.CustomerId);

            var userEmail = customer.CustomerEmail;
            if (!string.IsNullOrEmpty(userEmail))
            {
                var message = $"Reservation created for {userEmail}";
                var body = Encoding.UTF8.GetBytes(message);
                _channel.BasicPublish(exchange: "",
                                      routingKey: "reservationQueue",
                                      basicProperties: null,
                                      body: body);
            }
            await base.BeforeInsert(db, insert);
        }
    }
}
