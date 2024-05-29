﻿using eRestorante.Models.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class RatingStaffInsertRequest
    {
        [Required(ErrorMessage = "This field can not be empty.")]
        [Range(1, 5, ErrorMessage = "The rating number can be in a range from 1 to 5")]
        public int RatingNumber { get; set; }

        public int? CustomerId { get; set; }

        public int? UserId { get; set; }

    }
}
