using AutoMapper;
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
    public class BaseService<T, TDb> : IService<T> where TDb : class where T : class
    {
        Ib200192Context _context;
        public IMapper _mapper;

        public BaseService(Ib200192Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<T>> Get()
        {
            var query = _context.Set<TDb>().AsQueryable();

            var list = await query.ToListAsync();

            return _mapper.Map<List<T>>(list);
        }
    }
}
