using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
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

        [Authorize]
        public override Task<eRestorante.Models.Model.CommentStaff> Insert([FromBody] CommentStaffInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize]
        public override Task<eRestorante.Models.Model.CommentStaff> Update(int id, [FromBody] CommentStaffUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize]
        public override Task<IActionResult> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
