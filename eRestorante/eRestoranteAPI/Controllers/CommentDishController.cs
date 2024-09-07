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
    public class CommentDishController : BaseCRUDController<eRestorante.Models.Model.CommentDish, eRestorante.Models.SearchObjects.CommentDishSearchObject, CommentDishInsertRequest, CommentDishUpdateRequest>
    {
        public CommentDishController(ILogger<BaseController<eRestorante.Models.Model.CommentDish, eRestorante.Models.SearchObjects.CommentDishSearchObject>> logger, ICommentDishService service) : base(logger, service)
        {
        }

        [AllowAnonymous]
        public override Task<eRestorante.Models.Model.CommentDish> Insert([FromBody] CommentDishInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [AllowAnonymous]
        public override Task<eRestorante.Models.Model.CommentDish> Update(int id, [FromBody] CommentDishUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [AllowAnonymous]
        public override Task<IActionResult> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
