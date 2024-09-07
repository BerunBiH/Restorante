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
    public class CommentDishService : BaseCRUDService<Models.Model.CommentDish, Database.CommentDish, CommentDishSearchObject, CommentDishInsertRequest, CommentDishUpdateRequest>, ICommentDishService
    {
        public CommentDishService(Ib200192Context context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<Database.CommentDish> AddFilter(IQueryable<Database.CommentDish> query, CommentDishSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.CommentFTS))
            {
                query = query.Where(x => x.CommentText.Contains(search.CommentFTS));
            }

            if (search?.CustomerId!=null)
            {
                query = query.Where(x => x.CustomerId==search.CustomerId);
            }

            return base.AddFilter(query, search);
        }

        public override Task BeforeInsert(Database.CommentDish db, CommentDishInsertRequest insert)
        {
            DateOnly currentDate = DateOnly.FromDateTime(DateTime.Now);
            db.CommentDate = currentDate;
            return base.BeforeInsert(db, insert);
        }

    }
}
