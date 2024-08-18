using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestorante.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddNewPropertyToYourEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ReservationStatus",
                table: "Reservations",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ReservationStatus",
                table: "Reservations");
        }
    }
}
