using eRestorante.Services.Database;
using eRestorante.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eRestorante.Models.Requests;

namespace eRestorante.Services
{
    public interface IUserService
    {
        List<eRestorante.Models.User> Get();
        Models.User Insert(UserInsertRequest request);
        Models.User Update(int id, UserUpdateRequest request);
    }
}
