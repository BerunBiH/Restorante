using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services
{
    public interface IDrinkService
    {
        Task<List<eRestorante.Models.Drink>> Get();
    }
}
