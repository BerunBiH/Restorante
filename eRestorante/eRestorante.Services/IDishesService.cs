﻿using eRestorante.Model;
using eRestorante.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services
{
    public interface IDishesService
    {
        IList<Dish> Get();
    }
}
