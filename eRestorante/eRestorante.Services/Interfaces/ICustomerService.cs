using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eRestorante.Models.Model;
using eRestorante.Models.SearchObjects;

namespace eRestorante.Services.Interfaces
{
    public interface ICustomerService : IService<Models.Model.Customer, CustomerSearchObject>
    {
    }
}
