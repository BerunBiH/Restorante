using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Model
{
    public partial class CommentDish
    {
        public int CommentDishId { get; set; }

        public DateOnly CommentDate { get; set; }

        public string CommentText { get; set; } = null!;

        public int? CustomerId { get; set; }

        public int? DishId { get; set; }

        public virtual Customer? Customer { get; set; }

        public virtual Dishes? Dish { get; set; }
    }
}
