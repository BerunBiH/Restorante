using eRestorante.Models.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Interfaces
{
    public interface IService<T, TSearch> where TSearch : class
    {
        Task<PageResult<T>> Get(TSearch search = null);
        Task<T> GetById(int id);
    }
}
