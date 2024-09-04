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
        private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost";
        private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
        private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
        private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

        public ReservationService(Ib200192Context context, IMapper mapper)
            : base(context, mapper)
        {

            var factory = new ConnectionFactory
            {
                HostName = _host,
                UserName = _username,
                Password = _password
            };
            var connection = factory.CreateConnection();
            _channel = connection.CreateModel();
            _channel.QueueDeclare(queue: "reservationQueue",
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: false,
                                 arguments: null);
        }

        public override IQueryable<Database.Reservation> AddFilter(IQueryable<Database.Reservation> query, ReservationSearchObject? search = null)
        {
            if (search.ReservationDate!=null)
            {
                query = query.Where(x => x.ReservationDate==search.ReservationDate);
            }

            if (search.CustomerId != null)
            {
                query = query.Where(x => x.CustomerId == search.CustomerId);
            }

            return base.AddFilter(query, search);
        }

        public override async Task BeforeInsert(Database.Reservation db, ReservationInsertRequest insert)
        {

            insert.ReservationStatus = 0;

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

        public override IQueryable<Database.Reservation> AddInclude(IQueryable<Database.Reservation> query, ReservationSearchObject? search = null)
        {
            query = query.Include("Customer");

            return base.AddInclude(query, search);
        }
    }
}
