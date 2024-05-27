using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class CommentDishInsertRequest
    {

        public string CommentText { get; set; } = null!;

        public int? CustomerId { get; set; }

        public int? DishId { get; set; }

    }
}
