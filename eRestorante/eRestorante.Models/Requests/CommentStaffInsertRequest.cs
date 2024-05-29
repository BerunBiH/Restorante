using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class CommentStaffInsertRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [MaxLength(1000, ErrorMessage = "The comment can't have more than 1000 characters.")]
        public string CommentText { get; set; } = null!;

        public int? CustomerId { get; set; }

        public int? UserId { get; set; }

    }
}
