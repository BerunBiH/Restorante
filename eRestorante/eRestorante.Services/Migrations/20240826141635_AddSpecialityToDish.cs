using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestorante.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddSpecialityToDish : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "Speciality",
                table: "Dishes",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Speciality",
                table: "Dishes");
        }
    }
}
