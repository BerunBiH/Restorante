using AutoMapper;
using eRestorante.Models.Model;
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
    public class CustomerService : BaseService<Models.Model.Customer, Database.Customer, CustomerSearchObject>, ICustomerService
    {
        public CustomerService(Ib200192Context context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<Database.Customer> AddFilter(IQueryable<Database.Customer> query, CustomerSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.CustomerName))
            {
                query = query.Where(x => x.CustomerName.StartsWith(search.CustomerName));
            }

            if (!string.IsNullOrWhiteSpace(search?.CustomerFTS))
            {
                query = query.Where(x => x.CustomerName.Contains(search.CustomerFTS));
            }

            return base.AddFilter(query, search);
        }

    }
}
