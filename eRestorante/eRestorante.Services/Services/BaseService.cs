using AutoMapper;
using eRestorante.Models.Model;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace eRestorante.Services.Services
{
    public class BaseService<T, TDb, TSearch> : IService<T, TSearch> where TDb : class where T : class where TSearch : BaseSearchObject
    {
        protected Ib200192Context _context;
        protected IMapper _mapper;

        public BaseService(Ib200192Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public virtual async Task<PageResult<T>> Get(TSearch? search = null)
        {
            var query = _context.Set<TDb>().AsQueryable();

            PageResult<T> result = new PageResult<T>();
            query = AddFilter(query, search);

            query = AddInclude(query, search);

            result.Count= await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query= query.Take(search.PageSize.Value).Skip(search.Page.Value*search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<T>>(list);
            result.Result = tmp;
            return result;
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual async Task<TDb> AddIncludeId(IQueryable<TDb> query, int id)
        {
            return (TDb)query;
        }

        public virtual async Task<T> GetById(int id)
        {
            var query = _context.Set<TDb>().AsQueryable();

            var entity = await AddIncludeId(query, id);

            return _mapper.Map<T>(entity);
        }
    }
}
