﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class CommentDishUpdateRequest
    {
        public string CommentText { get; set; } = null!;
    }
}