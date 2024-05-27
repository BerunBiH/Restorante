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
    public class CategoryService : BaseService<Models.Model.Category, Database.Category, Models.SearchObjects.CategorySearchObject>, ICategoryService
    {
        public CategoryService(Ib200192Context context, IMapper mapper)
            :base(context, mapper)
        {
        }

        public override IQueryable<Database.Category> AddFilter(IQueryable<Database.Category> query, CategorySearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.CategoryName))
            {
                query = query.Where(x => x.CategoryName.StartsWith(search.CategoryName));
            }
            return base.AddFilter(query, search);
        }
    }
}
