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
    public class RatingStaffService : BaseCRUDService<Models.Model.RatingStaff, Database.RatingStaff, RatingStaffSearchObject, RatingStaffInsertRequest, RatingStaffUpdateRequest>, IRatingStaffService
    {
        public RatingStaffService(Ib200192Context context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<Database.RatingStaff> AddFilter(IQueryable<Database.RatingStaff> query, RatingStaffSearchObject? search = null)
        {
            if (search?.RatingNumber!=null)
            {
                query = query.Where(x => x.RatingNumber==search.RatingNumber);
            }

            return base.AddFilter(query, search);
        }

        public override Task BeforeInsert(Database.RatingStaff db, RatingStaffInsertRequest insert)
        {
            DateOnly currentDate = DateOnly.FromDateTime(DateTime.Now);
            db.RatingDate = currentDate;
            return base.BeforeInsert(db, insert);
        }

    }
}
