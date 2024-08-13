using AutoMapper;
using Azure.Core;
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
    public class CustomerService : BaseCRUDService<Models.Model.Customer, Database.Customer, CustomerSearchObject, CustomerInsertRequest, CustomerUpdateRequest>, ICustomerService
    {
        public CustomerService(Ib200192Context context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<Database.Customer> AddFilter(IQueryable<Database.Customer> query, CustomerSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.CustomerName))
            {
                query = query.Where(x => x.CustomerName.StartsWith(search.CustomerName));
            }

            if (!string.IsNullOrWhiteSpace(search?.CustomerFTS))
            {
                query = query.Where(x => x.CustomerName.Contains(search.CustomerFTS) || x.CustomerSurname.Contains(search.CustomerFTS));
            }

            return base.AddFilter(query, search);
        }

        public override Task BeforeInsert(Database.Customer db, CustomerInsertRequest insert)
        {
            DateOnly currentDate = DateOnly.FromDateTime(DateTime.Now);
            db.CustomerDateRegister = currentDate;
            db.CustomerPassSalt = GenerateSalt();
            db.CustomerPassHash = GenerateHash(db.CustomerPassSalt, insert.CustomerPassword);
            return base.BeforeInsert(db, insert);
        }

        public override async Task<Task> BeforeRemove(Database.Customer db)
        {

            var entityRating = await _context.RatingStaffs.Where(x => x.CustomerId == db.CustomerId).ToListAsync();

            foreach (var rating in entityRating)
            {
                _context.RatingStaffs.Remove(rating);

                await _context.SaveChangesAsync();
            }

            var entityComment = await _context.CommentStaffs.Where(x => x.CustomerId == db.CustomerId).ToListAsync();

            foreach (var comment in entityComment)
            {
                _context.CommentStaffs.Remove(comment);

                await _context.SaveChangesAsync();
            }

            var entityRatingD = await _context.RatingDishes.Where(x => x.CustomerId == db.CustomerId).ToListAsync();

            foreach (var rating in entityRatingD)
            {
                _context.RatingDishes.Remove(rating);

                await _context.SaveChangesAsync();
            }

            var entityCommentD = await _context.CommentDishes.Where(x => x.CustomerId == db.CustomerId).ToListAsync();

            foreach (var comment in entityCommentD)
            {
                _context.CommentDishes.Remove(comment);

                await _context.SaveChangesAsync();
            }

            var entityReservations = await _context.Reservations.Where(x => x.CustomerId == db.CustomerId).ToListAsync();

            foreach (var comment in entityReservations)
            {
                _context.Reservations.Remove(comment);

                await _context.SaveChangesAsync();
            }

            var enetityOrder = await _context.Orders.Where(x => x.CustomerId == db.CustomerId).ToListAsync();

            foreach (var order in enetityOrder)
            {
                var enetityOrderDish = await _context.OrderDishes.Where(x => x.OrderId == order.OrdersId).ToListAsync();

                foreach (var dish in enetityOrderDish)
                {
                    _context.OrderDishes.Remove(dish);
                }

                var enetityOrderDrink = await _context.OrderDrinks.Where(x => x.OrderId == order.OrdersId).ToListAsync();
                foreach (var drink in enetityOrderDrink)

                {
                    _context.OrderDrinks.Remove(drink);
                }

                _context.Orders.Remove(order);

                await _context.SaveChangesAsync();
            }

            return base.BeforeRemove(db);
        }

    }
}
