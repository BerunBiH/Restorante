using System;
using System.Collections.Generic;

namespace eRestorante.Services.Database;

public partial class User
{
    public int UserId { get; set; }

    public string UserName { get; set; } = null!;

    public string UserSurname { get; set; } = null!;

    public string UserEmail { get; set; } = null!;

    public string UserPhone { get; set; } = null!;

    public string UserPassHash { get; set; } = null!;

    public string UserPassSalt { get; set; } = null!;

    public byte? UserStatus { get; set; }

    public byte[]? UserImage { get; set; }

    public virtual ICollection<CommentStaff> CommentStaffs { get; set; } = new List<CommentStaff>();

    public virtual ICollection<RatingStaff> RatingStaffs { get; set; } = new List<RatingStaff>();

    public virtual ICollection<UserRole> UserRoles { get; set; } = new List<UserRole>();
}
