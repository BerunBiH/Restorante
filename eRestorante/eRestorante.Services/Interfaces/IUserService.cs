using eRestorante.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eRestorante.Models.Requests;

namespace eRestorante.Services.Interfaces
{
    public interface IUserService
    {
        Task<List<Models.Model.User>> Get();
        Models.Model.User Insert(UserInsertRequest request);
        Models.Model.User Update(int id, UserUpdateRequest request);
    }
}
