using AutoMapper;
using eRestorante.Models.Model;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Services
{
    public class CustomerService : BaseService<Models.Model.Customer, Database.Customer>, ICustomerService
    {
        Ib200192Context _context;
        public IMapper _mapper;

        public CustomerService(Ib200192Context context, IMapper mapper)
            : base(context, mapper)
        {

        }

    }
}
