using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Model
{
    public partial class User
    {
        public int UserId { get; set; }

        public string UserName { get; set; } = null!;

        public string UserSurname { get; set; } = null!;

        public string UserEmail { get; set; } = null!;

        public string UserPhone { get; set; } = null!;

        public byte? UserStatus { get; set; }

        public byte[]? UserImage { get; set; }

        public virtual ICollection<UserRole> UserRoles { get; set; } = new List<UserRole>();

        public virtual ICollection<CommentStaff> CommentStaffs { get; set; } = new List<CommentStaff>();

        public virtual ICollection<RatingStaff> RatingStaffs { get; set; } = new List<RatingStaff>();
    }
}
