using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace eRestoranteAPI.Controllers
{
    [ApiController]
    public class CommentStaffController : BaseCRUDController<eRestorante.Models.Model.CommentStaff, eRestorante.Models.SearchObjects.CommentStaffSearchObject, CommentStaffInsertRequest, CommentStaffUpdateRequest>
    {
        public CommentStaffController(ILogger<BaseController<eRestorante.Models.Model.CommentStaff, eRestorante.Models.SearchObjects.CommentStaffSearchObject>> logger, ICommentStaffService service) : base(logger, service)
        {
        }
    }
}
