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
    public class RatingDishService : BaseCRUDService<Models.Model.RatingDish, Database.RatingDish, RatingDishSearchObject, RatingDishInsertRequest, RatingDishUpdateRequest>, IRatingDishService
    {
        public RatingDishService(Ib200192Context context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<Database.RatingDish> AddFilter(IQueryable<Database.RatingDish> query, RatingDishSearchObject? search = null)
        {
            if (search?.RatingNumber!=null)
            {
                query = query.Where(x => x.RatingNumber==search.RatingNumber);
            }

            return base.AddFilter(query, search);
        }

        public override Task BeforeInsert(Database.RatingDish db, RatingDishInsertRequest insert)
        {
            DateOnly currentDate = DateOnly.FromDateTime(DateTime.Now);
            db.RatingDate = currentDate;
            return base.BeforeInsert(db, insert);
        }

    }
}
