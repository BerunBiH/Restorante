using eRestorante.Services.Database;
using eRestorante.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services
{
    public interface IUserService
    {
        List<Model.User> Get();    
    }
}
