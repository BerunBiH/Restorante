using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Models.Requests
{
    public class ReservationUpdateRequest
    {
        [Required(ErrorMessage = "This field can not be empty.")]
        public DateOnly ReservationDate { get; set; }

        [Required(ErrorMessage = "This field can not be empty.")]
        public TimeOnly ReservationTime { get; set; }

        [Required(ErrorMessage = "This field can not be empty.")]
        [Range(1, 100, ErrorMessage = "The number of guests can be in a range from 1 to 100")]
        public int NumberOfGuests { get; set; }

        [Required(ErrorMessage = "This field can not be empty.")]
        [Range(1, 16, ErrorMessage = "The number of hours of the reservation can be in a range from 1 to 16")]
        public int NumberOfHours { get; set; }

        [Range(0, 2, ErrorMessage = "The number of hours of the reservation can be in a range from 0 to 2")]
        public int? ReservationStatus { get; set; }

        [MaxLength(1000, ErrorMessage = "The reservation reason can't have more than 1000 characters.")]
        public string? ReservationReason { get; set; }

        [Range(0, 100, ErrorMessage = "The number of minors can be in a range from 0 to 100")]
        public int? NumberOfMinors { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [Phone(ErrorMessage = "The phone needs to be in a valid format")]
        public string ContactPhone { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "This field can not be empty.")]
        [MaxLength(1000, ErrorMessage = "The special wish reason can't have more than 1000 characters.")]
        public string SpecialWishes { get; set; } = null!;

    }
}
