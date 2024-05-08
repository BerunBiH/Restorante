﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class UserInsertRequest
    {

        public string UserName { get; set; } = null!;

        public string UserSurname { get; set; } = null!;

        public string UserEmail { get; set; } = null!;

        public string UserPhone { get; set; } = null!;

        public string UserPassword { get; set; } = null!;

        public string UserPasswordRepeat { get; set; } = null!;

        public byte? UserStatus { get; set; }

        public byte[]? UserImage { get; set; }
    }
}
