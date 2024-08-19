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
    public class DishService : BaseCRUDService<Models.Model.Dishes, Database.Dish, Models.SearchObjects.DishSearchObject, Models.Requests.DishInsertRequest, Models.Requests.DishUpdateRequest>, IDishesService
    {
        public DishService(Ib200192Context context, IMapper mapper)
            :base(context, mapper)
        {  
        }

        public override Task BeforeUpdate(Dish db, DishUpdateRequest update)
        {
            if (update.DishCost<=0)
            {
                throw new UserException("The cost of the dish can't be equal to or less than zero.");
                update.DishCost = db.DishCost;
            }
            
            return base.BeforeUpdate(db, update);

        }

        public override IQueryable<Dish> AddFilter(IQueryable<Dish> query, DishSearchObject? search = null)
        {

            if (!string.IsNullOrWhiteSpace(search?.DishName))
            {
                query = query.Where(x => x.DishName.Contains(search.DishName));
            }

            return base.AddFilter(query, search);
        }

        public override async Task<Task> BeforeRemove(Dish db)
        {
            var entityRatingD = await _context.RatingDishes.Where(x => x.DishId == db.DishId).ToListAsync();

            foreach (var rating in entityRatingD)
            {
                _context.RatingDishes.Remove(rating);

                await _context.SaveChangesAsync();
            }

            var entityCommentD = await _context.CommentDishes.Where(x => x.DishId == db.DishId).ToListAsync();

            foreach (var comment in entityCommentD)
            {
                _context.CommentDishes.Remove(comment);

                await _context.SaveChangesAsync();
            }

            var entityOrderD = await _context.OrderDishes.Where(x => x.DishId == db.DishId).ToListAsync();

            foreach (var orderD in entityOrderD)
            {
                _context.OrderDishes.Remove(orderD);

                await _context.SaveChangesAsync();
            }

            return base.BeforeRemove(db);
        }
    }
}
