using eRestorante.Models.Exceptions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Net;

namespace eRestoranteAPI.Filters
{
    public class ErrorFilter : ExceptionFilterAttribute
    {

        public override void OnException(ExceptionContext context)
        {
            if(context.Exception is UserException)
            {
                context.ModelState.AddModelError("error", context.Exception.Message);
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            }
            else
            {
                context.ModelState.AddModelError("ERROR", "Server side error");
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            }

            var list = context.ModelState.Where(x => x.Value.Errors.Count() > 0)
                .ToDictionary(x => x.Key, y => y.Value.Errors.Select(z => z.ErrorMessage));

            context.Result = new JsonResult(new { errors = list });
        }

    }
}
