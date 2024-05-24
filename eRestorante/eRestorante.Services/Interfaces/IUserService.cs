using eRestorante.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eRestorante.Models.Requests;

namespace eRestorante.Services.Interfaces
{
    public interface IUserService : IBaseCRUDService<Models.Model.User, Models.SearchObjects.UserSearchObject,UserInsertRequest,UserUpdateRequest>
    {

        public Task<Models.Model.User> Login(string email, string password);

    }
}
