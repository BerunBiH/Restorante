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
    public class CommentStaffService : BaseCRUDService<Models.Model.CommentStaff, Database.CommentStaff, CommentStaffSearchObject, CommentStaffInsertRequest, CommentStaffUpdateRequest>, ICommentStaffService
    {
        public CommentStaffService(Ib200192Context context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<Database.CommentStaff> AddFilter(IQueryable<Database.CommentStaff> query, CommentStaffSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.CommentFTS))
            {
                query = query.Where(x => x.CommentText.Contains(search.CommentFTS));
            }

            return base.AddFilter(query, search);
        }

        public override Task BeforeInsert(Database.CommentStaff db, CommentStaffInsertRequest insert)
        {
            DateOnly currentDate = DateOnly.FromDateTime(DateTime.Now);
            db.CommentDate = currentDate;
            return base.BeforeInsert(db, insert);
        }

    }
}
