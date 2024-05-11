using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.SearchObjects
{
    public class BaseSearchObject
    {
        public int? Page { get; set; }
        public int? PageSize { get; set; }
    }
}
