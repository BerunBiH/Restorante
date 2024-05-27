using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Model
{
    public partial class RatingDish
    {
        public int RatingId { get; set; }

        public int RatingNumber { get; set; }

        public DateOnly RatingDate { get; set; }

        public int? CustomerId { get; set; }

        public int? DishId { get; set; }

        public virtual Customer? Customer { get; set; }

        public virtual Dishes? Dish { get; set; }
    }
}
