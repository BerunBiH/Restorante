using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using eRestorante.Services.Services;
using eRestoranteAPI.Authentication;
using eRestoranteAPI.Filters;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using RabbitMQ.Client;
using System;
using System.Security.Cryptography;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddSwaggerGen(options =>
{
    options.CustomSchemaIds(type => type.ToString());
});

builder.Services.AddTransient<IDishesService, DishService>();
builder.Services.AddTransient<IRoleService, RoleService>();
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<IUserRoleService, UserRoleService>();
builder.Services.AddTransient<IOrderService, OrderService>();
builder.Services.AddTransient<IDrinkService, DrinkService>();
builder.Services.AddTransient<ICustomerService, CustomerService>();
builder.Services.AddTransient<ICategoryService, CategoryService>();
builder.Services.AddTransient<IOrderDishesService, OrderDishesService>();
builder.Services.AddTransient<IOrderDrinksService, OrderDrinksService>();
builder.Services.AddTransient<IReservationService, ReservationService>();
builder.Services.AddTransient<ICommentDishService, CommentDishService>();
builder.Services.AddTransient<ICommentStaffService, CommentStaffService>();
builder.Services.AddTransient<IRatingStaffService, RatingStaffService>();
builder.Services.AddTransient<IRatingDishService, RatingDishService>();

builder.Services.AddControllers( x=>
{
    x.Filters.Add<ErrorFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(a =>
{
    a.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    a.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
        {
        new OpenApiSecurityScheme
        {
            Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id = "basicAuth" }
        },
        new string[]{}
        }
    });
}
);
builder.Configuration.AddEnvironmentVariables();

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<Ib200192Context>(options =>
        options.UseSqlServer(connectionString));
Console.WriteLine(connectionString);

builder.Services.AddAutoMapper(typeof(IUserService));
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

var rabbitMqFactory = new ConnectionFactory() { HostName = builder.Configuration["RabbitMQ:HostName"] };
builder.Services.AddSingleton(rabbitMqFactory);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<Ib200192Context>();
    if (dataContext.Database.EnsureCreated())
    {
        dataContext.Database.Migrate();

        dataContext.Categories.AddRange(
            new Category { CategoryId = 1, CategoryName = "Italijanska hrana" },
            new Category { CategoryId = 2, CategoryName = "Domaća hrana" },
            new Category { CategoryId = 3, CategoryName = "Brza hrana" },
            new Category { CategoryId = 4, CategoryName = "Vegetarijanska jela" },
            new Category { CategoryId = 5, CategoryName = "Morski plodovi" },
            new Category { CategoryId = 6, CategoryName = "Roštilj" },
            new Category { CategoryId = 7, CategoryName = "Azijska kuhinja" },
            new Category { CategoryId = 8, CategoryName = "Deserti" },
            new Category { CategoryId = 9, CategoryName = "Bezglutenska jela" },
            new Category { CategoryId = 10, CategoryName = "Pića" }
        );

        dataContext.Roles.AddRange(
            new Role { RoleName = "Konobar", RoleDescription = "Konobar je zaduzen za dostavljanje hrane od kuhinje do gostiju" },
            new Role { RoleName = "Menedzer", RoleDescription = "Menedzer je zaduzen za postavljanje radnika na zaduzenja kao i sve ostalo sto je vazno" },
            new Role { RoleName = "Gost", RoleDescription = "Gost je uvijek na prvom mjestu kod nas." },
            new Role { RoleName = "Kuhar", RoleDescription = "Kuhar je nas specijalista za hranu koja sprema najukusnija jela od najljepsih sastojaka" },
            new Role { RoleName = "Šanker", RoleDescription = "Šanker je nas specijalista za sankom, uvijek tu da svojom pricom sviju oraspolozi." }
        );


        string plainPassword = "korisnik";

        dataContext.Customers.Add(CreateCustomer(1, "Korisnik", "Korisnik", "korisnik.korisnik@gmail.com", "+38761123456", plainPassword));
        dataContext.Customers.Add(CreateCustomer(2, "Amir", "Hodžić", "amir.hodzic@example.com", "+38761123456", plainPassword));
        dataContext.Customers.Add(CreateCustomer(3, "Jasna", "Kovačević", "jasna.kovacevic@example.com", "+38761123457", plainPassword));
        dataContext.Customers.Add(CreateCustomer(4, "Nermin", "Delić", "nermin.delic@example.com", "+38761123458", plainPassword));
        dataContext.Customers.Add(CreateCustomer(5, "Ivana", "Jurić", "ivana.juric@example.com", "+38761123459", plainPassword));
        dataContext.Customers.Add(CreateCustomer(6, "Adnan", "Begović", "adnan.begovic@example.com", "+38761123460", plainPassword));
        dataContext.Customers.Add(CreateCustomer(7, "Lejla", "Halilović", "lejla.halilovic@example.com", "+38761123461", plainPassword));
        dataContext.Customers.Add(CreateCustomer(8, "Haris", "Mujanović", "haris.mujanovic@example.com", "+38761123462", plainPassword));
        dataContext.Customers.Add(CreateCustomer(9, "Selma", "Đurić", "selma.djuric@example.com", "+38761123463", plainPassword));
        dataContext.Customers.Add(CreateCustomer(10, "Emina", "Hasanović", "emina.hasanovic@example.com", "+38761123464", plainPassword));
        dataContext.Customers.Add(CreateCustomer(11, "Tarik", "Vuković", "tarik.vukovic@example.com", "+38761123465", plainPassword));

        dataContext.Dishes.AddRange(new Dish
        {
            DishName = "Pizza Margherita",
            DishDescription = "Tradicionalna talijanska pizza s rajčicama, mocarelom i bosiljkom.",
            DishCost = 12.50m,
            Speciality = true,
            CategoryId = 1
        },
        new Dish
        {
            DishName = "Ćevapi",
            DishDescription = "Domaći roštilj s mesnim ćevapima i lepinjom.",
            DishCost = 8.00m,
            Speciality = true,
            CategoryId = 2
        },
        new Dish
        {
            DishName = "Vegetarijanski burger",
            DishDescription = "Burger od povrća, s avokadom i povrtnom salatom.",
            DishCost = 9.50m,
            Speciality = false,
            CategoryId = 4
        },
        new Dish
        {
            DishName = "Tuna steak",
            DishDescription = "Odresci tune sa sezonskom salatom i citrusnim dresingom.",
            DishCost = 15.75m,
            Speciality = true,
            CategoryId = 5
        },
        new Dish
        {
            DishName = "Falafel wrap",
            DishDescription = "Wrap s falafelom, humusom i svježom salatom.",
            DishCost = 6.50m,
            Speciality = false,
            CategoryId = 4
        },
        new Dish
        {
            DishName = "Kung Pao piletina",
            DishDescription = "Piletina s kikirikijem i povrćem u ljutom kineskom umaku.",
            DishCost = 13.25m,
            Speciality = true,
            CategoryId = 7
        },
        new Dish
        {
            DishName = "Kolač od čokolade",
            DishDescription = "Dekadentni desert od tamne čokolade s preljevom od bobičastog voća.",
            DishCost = 5.00m,
            Speciality = false,
            CategoryId = 8
        },
        new Dish
        {
            DishName = "Bezglutenska pizza",
            DishDescription = "Pizza napravljena od bezglutenskog tijesta s povrćem i mocarelom.",
            DishCost = 11.00m,
            Speciality = true,
            CategoryId = 9
        },
        new Dish
        {
            DishName = "Šopska salata",
            DishDescription = "Tradicionalna balkanska salata s krastavcima, paradajzom i fetom.",
            DishCost = 4.75m,
            Speciality = false,
            CategoryId = 2
        },
        new Dish
        {
            DishName = "Špagete",
            DishDescription = "Klasična talijansko jelo koje svi vole.",
            DishCost = 2.50m,
            Speciality = true,
            CategoryId = 10
        }
    );

        dataContext.Drinks.AddRange(
            new Drink
            {
                DrinkName = "Coca-Cola",
                DrinkDescription = "Gazirani bezalkoholni napitak.",
                DrinkCost = 2.00m,
                DrinkAlcoholPerc = 0, // No alcohol
                CategoryId = 10 // Pića
            },
        new Drink
        {
            DrinkName = "Fanta",
            DrinkDescription = "Gazirani bezalkoholni napitak s okusom narandže.",
            DrinkCost = 2.00m,
            DrinkAlcoholPerc = 0, // No alcohol
            CategoryId = 10 // Pića
        },
        new Drink
        {
            DrinkName = "Sprite",
            DrinkDescription = "Gazirani bezalkoholni napitak s okusom limuna i limete.",
            DrinkCost = 2.00m,
            DrinkAlcoholPerc = 0, // No alcohol
            CategoryId = 10 // Pića
        },
        new Drink
        {
            DrinkName = "Espresso",
            DrinkDescription = "Klasična talijanska kafa s bogatim okusom.",
            DrinkCost = 2.50m,
            DrinkAlcoholPerc = 0, // No alcohol
            CategoryId = 10 // Pića
        },
        new Drink
        {
            DrinkName = "Cappuccino",
            DrinkDescription = "Italijanski topli napitak od kafe s mlijekom i pjenom.",
            DrinkCost = 3.00m,
            DrinkAlcoholPerc = 0, // No alcohol
            CategoryId = 10 // Pića
        },
        new Drink
        {
            DrinkName = "Crveno vino",
            DrinkDescription = "Fino crveno vino s bogatim okusom bobičastog voća.",
            DrinkCost = 7.50m,
            DrinkAlcoholPerc = 12.5m, // 12.5% alcohol
            CategoryId = 10 // Pića
        },
        new Drink
        {

            DrinkName = "Bijelo vino",
            DrinkDescription = "Sofisticirano bijelo vino s notama citrusa.",
            DrinkCost = 7.00m,
            DrinkAlcoholPerc = 11.5m, // 11.5% alcohol
            CategoryId = 10 // Pića
        },
        new Drink
        {
            DrinkName = "Pivo",
            DrinkDescription = "Osvežavajuće pivo s hmeljnim okusom.",
            DrinkCost = 3.50m,
            DrinkAlcoholPerc = 5.0m, // 5% alcohol
            CategoryId = 10 // Pića
        },
        new Drink
        {
            DrinkName = "Tequila",
            DrinkDescription = "Jaki alkoholni napitak od plave agave.",
            DrinkCost = 5.00m,
            DrinkAlcoholPerc = 40.0m, // 40% alcohol
            CategoryId = 10 // Pića
        },
        new Drink
        {
            DrinkName = "Mojito",
            DrinkDescription = "Osvežavajući koktel s rumom, limetom i mentom.",
            DrinkCost = 6.00m,
            DrinkAlcoholPerc = 10.0m, // 10% alcohol
            CategoryId = 10 // Pića
        }
    );

        string password = "admin"; // Same password for demonstration

        string salt1 = GenerateSalt();
        string hash1 = GenerateHash(salt1, password);

        dataContext.Users.AddRange(
            new User
            {
                UserName = "Admin",
                UserSurname = "Admin",
                UserEmail = "admin.admin@gmail.com",
                UserPhone = "061111111",
                UserPassHash = hash1,
                UserPassSalt = salt1,
                UserStatus = 1
            },
        new User
        {
            UserName = "Selma",
            UserSurname = "Mahmutović",
            UserEmail = "selma.mahmutovic@example.com",
            UserPhone = "061222222",
            UserPassHash = hash1,
            UserPassSalt = salt1,
            UserStatus = 1
        },
        new User
        {
            UserName = "Haris",
            UserSurname = "Mehmedović",
            UserEmail = "haris.mehmedovic@example.com",
            UserPhone = "061333333",
            UserPassHash = hash1,
            UserPassSalt = salt1,
            UserStatus = 1
        },
        new User
        {
            UserName = "Lejla",
            UserSurname = "Kovačević",
            UserEmail = "lejla.kovacevic@example.com",
            UserPhone = "061444444",
            UserPassHash = hash1,
            UserPassSalt = salt1,
            UserStatus = 1
        },
        new User
        {
            UserName = "Adnan",
            UserSurname = "Halilović",
            UserEmail = "adnan.halilovic@example.com",
            UserPhone = "061555555",
            UserPassHash = hash1,
            UserPassSalt = salt1,
            UserStatus = 1
        },
        new User
        {
            UserName = "Aida",
            UserSurname = "Ibrahimović",
            UserEmail = "aida.ibrahimovic@example.com",
            UserPhone = "061666666",
            UserPassHash = hash1,
            UserPassSalt = salt1,
            UserStatus = 1
        },
        new User
        {
            UserName = "Dino",
            UserSurname = "Smajić",
            UserEmail = "dino.smajic@example.com",
            UserPhone = "061777777",
            UserPassHash = hash1,
            UserPassSalt = salt1,
            UserStatus = 1
        },
        new User
        {
            UserName = "Jasmina",
            UserSurname = "Begović",
            UserEmail = "jasmina.begovic@example.com",
            UserPhone = "061888888",
            UserPassHash = hash1,
            UserPassSalt = salt1,
            UserStatus = 1
        },
        new User
        {
            UserName = "Mirza",
            UserSurname = "Tomić",
            UserEmail = "mirza.tomic@example.com",
            UserPhone = "061999999",
            UserPassHash = hash1,
            UserPassSalt = salt1,
            UserStatus = 1
        },
        new User
        {
            UserName = "Elma",
            UserSurname = "Zukić",
            UserEmail = "elma.zukic@example.com",
            UserPhone = "061000000",
            UserPassHash = hash1,
            UserPassSalt = salt1,
            UserStatus = 1
        }
    );
        dataContext.SaveChanges();
        dataContext.UserRoles.AddRange(
            new UserRole
            {
                UserId = 1,
                RoleId = 2,
                DateChange = DateOnly.FromDateTime(DateTime.Now)
            },
        new UserRole
        {
            UserId = 2,
            RoleId = 2,
            DateChange = DateOnly.FromDateTime(DateTime.Now)
        },
        new UserRole
        {
            UserId = 3,
            RoleId = 4,
            DateChange = DateOnly.FromDateTime(DateTime.Now)
        },
        new UserRole
        {
            UserId = 4,
            RoleId = 5,
            DateChange = DateOnly.FromDateTime(DateTime.Now)
        },
        new UserRole
        {
            UserId = 5,
            RoleId = 5,
            DateChange = DateOnly.FromDateTime(DateTime.Now)
        },
        new UserRole
        {
            UserId = 6,
            RoleId = 2,
            DateChange = DateOnly.FromDateTime(DateTime.Now)
        },
        new UserRole
        {
            UserId = 7,
            RoleId = 1,
            DateChange = DateOnly.FromDateTime(DateTime.Now)
        },
        new UserRole
        {
            UserId = 8,
            RoleId = 3,
            DateChange = DateOnly.FromDateTime(DateTime.Now)
        },
        new UserRole
        {
            UserId = 9,
            RoleId = 2,
            DateChange = DateOnly.FromDateTime(DateTime.Now)
        },
        new UserRole
        {
            UserId = 10,
            RoleId = 5,
            DateChange = DateOnly.FromDateTime(DateTime.Now)
        }
    );

        dataContext.Reservations.AddRange(
            new Reservation
            {
                ReservationDate = DateOnly.FromDateTime(new DateTime(2024, 9, 10)),
                ReservationTime = new TimeOnly(18, 30),
                NumberOfGuests = 4,
                NumberOfHours = 2,
                ReservationStatus = 1,
                CustomerId = 1,
                ReservationReason = "Family Dinner",
                NumberOfMinors = 1,
                ContactPhone = "+38762123456",
                SpecialWishes = "Highchair for a child"
            },
        new Reservation
        {
            ReservationDate = DateOnly.FromDateTime(new DateTime(2024, 9, 11)),
            ReservationTime = new TimeOnly(20, 0),
            NumberOfGuests = 2,
            NumberOfHours = 1,
            ReservationStatus = 1,
            CustomerId = 2,
            ReservationReason = "Date Night",
            NumberOfMinors = 0,
            ContactPhone = "+38762123457",
            SpecialWishes = "Romantic table by the window"
        },
        new Reservation
        {
            ReservationDate = DateOnly.FromDateTime(new DateTime(2024, 9, 12)),
            ReservationTime = new TimeOnly(19, 15),
            NumberOfGuests = 3,
            NumberOfHours = 2,
            ReservationStatus = 0,
            CustomerId = 3,
            ReservationReason = "Business Meeting",
            NumberOfMinors = 0,
            ContactPhone = "+38762123458",
            SpecialWishes = "Quiet table"
        },
        new Reservation
        {
            ReservationDate = DateOnly.FromDateTime(new DateTime(2024, 9, 13)),
            ReservationTime = new TimeOnly(17, 45),
            NumberOfGuests = 6,
            NumberOfHours = 3,
            ReservationStatus = 2,
            CustomerId = 4,
            ReservationReason = "Birthday Celebration",
            NumberOfMinors = 2,
            ContactPhone = "+38762123459",
            SpecialWishes = "Birthday cake surprise"
        },
        new Reservation
        {
            ReservationDate = DateOnly.FromDateTime(new DateTime(2024, 9, 14)),
            ReservationTime = new TimeOnly(19, 30),
            NumberOfGuests = 5,
            NumberOfHours = 2,
            ReservationStatus = 1,
            CustomerId = 5,
            ReservationReason = "Family Dinner",
            NumberOfMinors = 2,
            ContactPhone = "+38762123460",
            SpecialWishes = "Table with good view"
        },
        new Reservation
        {
            ReservationDate = DateOnly.FromDateTime(new DateTime(2024, 9, 15)),
            ReservationTime = new TimeOnly(21, 0),
            NumberOfGuests = 2,
            NumberOfHours = 1,
            ReservationStatus = 0,
            CustomerId = 6,
            ReservationReason = "Anniversary Dinner",
            NumberOfMinors = 0,
            ContactPhone = "+38762123461",
            SpecialWishes = "Private table for two"
        },
        new Reservation
        {
            ReservationDate = DateOnly.FromDateTime(new DateTime(2024, 9, 16)),
            ReservationTime = new TimeOnly(13, 0),
            NumberOfGuests = 8,
            NumberOfHours = 3,
            ReservationStatus = 1,
            CustomerId = 7,
            ReservationReason = "Team Lunch",
            NumberOfMinors = 0,
            ContactPhone = "+38762123462",
            SpecialWishes = "Large table near the entrance"
        },
        new Reservation
        {
            ReservationDate = DateOnly.FromDateTime(new DateTime(2024, 9, 17)),
            ReservationTime = new TimeOnly(18, 0),
            NumberOfGuests = 3,
            NumberOfHours = 2,
            ReservationStatus = 2,
            CustomerId = 8,
            ReservationReason = "Casual Dinner",
            NumberOfMinors = 1,
            ContactPhone = "+38762123463",
            SpecialWishes = "Booth seating"
        },
        new Reservation
        {
            ReservationDate = DateOnly.FromDateTime(new DateTime(2024, 9, 18)),
            ReservationTime = new TimeOnly(20, 30),
            NumberOfGuests = 2,
            NumberOfHours = 1,
            ReservationStatus = 1,
            CustomerId = 9,
            ReservationReason = "Special Occasion",
            NumberOfMinors = 0,
            ContactPhone = "+38762123464",
            SpecialWishes = "Extra flowers on table"
        },
        new Reservation
        {
            ReservationDate = DateOnly.FromDateTime(new DateTime(2024, 9, 19)),
            ReservationTime = new TimeOnly(19, 45),
            NumberOfGuests = 7,
            NumberOfHours = 3,
            ReservationStatus = 0,
            CustomerId = 10,
            ReservationReason = "Graduation Party",
            NumberOfMinors = 3,
            ContactPhone = "+38762123465",
            SpecialWishes = "Custom decorations"
        }
    );

        dataContext.RatingStaffs.AddRange(
            new RatingStaff { RatingNumber = 5, RatingDate = new DateOnly(2024, 9, 1), CustomerId = 1, UserId = 1 },
            new RatingStaff { RatingNumber = 4, RatingDate = new DateOnly(2024, 9, 2), CustomerId = 2, UserId = 2 },
            new RatingStaff { RatingNumber = 3, RatingDate = new DateOnly(2024, 9, 3), CustomerId = 3, UserId = 3 },
            new RatingStaff { RatingNumber = 5, RatingDate = new DateOnly(2024, 9, 4), CustomerId = 4, UserId = 4 },
            new RatingStaff { RatingNumber = 2, RatingDate = new DateOnly(2024, 9, 5), CustomerId = 5, UserId = 5 },
            new RatingStaff { RatingNumber = 4, RatingDate = new DateOnly(2024, 9, 6), CustomerId = 6, UserId = 6 },
            new RatingStaff { RatingNumber = 5, RatingDate = new DateOnly(2024, 9, 7), CustomerId = 7, UserId = 7 },
            new RatingStaff { RatingNumber = 3, RatingDate = new DateOnly(2024, 9, 8), CustomerId = 8, UserId = 8 },
            new RatingStaff { RatingNumber = 4, RatingDate = new DateOnly(2024, 9, 9), CustomerId = 9, UserId = 9 },
            new RatingStaff { RatingNumber = 5, RatingDate = new DateOnly(2024, 9, 10), CustomerId = 10, UserId = 10 }
            );

        dataContext.RatingDishes.AddRange(

            new RatingDish { RatingNumber = 5, RatingDate = new DateOnly(2024, 9, 1), CustomerId = 1, DishId = 1 },
            new RatingDish { RatingNumber = 4, RatingDate = new DateOnly(2024, 9, 2), CustomerId = 2, DishId = 2 },
            new RatingDish { RatingNumber = 3, RatingDate = new DateOnly(2024, 9, 3), CustomerId = 3, DishId = 3 },
            new RatingDish { RatingNumber = 5, RatingDate = new DateOnly(2024, 9, 4), CustomerId = 4, DishId = 4 },
            new RatingDish { RatingNumber = 2, RatingDate = new DateOnly(2024, 9, 5), CustomerId = 5, DishId = 5 },
            new RatingDish { RatingNumber = 4, RatingDate = new DateOnly(2024, 9, 6), CustomerId = 6, DishId = 6 },
            new RatingDish { RatingNumber = 5, RatingDate = new DateOnly(2024, 9, 7), CustomerId = 7, DishId = 7 },
            new RatingDish { RatingNumber = 3, RatingDate = new DateOnly(2024, 9, 8), CustomerId = 8, DishId = 8 },
            new RatingDish { RatingNumber = 4, RatingDate = new DateOnly(2024, 9, 9), CustomerId = 9, DishId = 9 },
            new RatingDish { RatingNumber = 5, RatingDate = new DateOnly(2024, 9, 10), CustomerId = 10, DishId = 10 },
            new RatingDish { RatingNumber = 3, RatingDate = new DateOnly(2024, 9, 11), CustomerId = 1, DishId = 2 },
            new RatingDish { RatingNumber = 5, RatingDate = new DateOnly(2024, 9, 12), CustomerId = 2, DishId = 3 },
            new RatingDish { RatingNumber = 4, RatingDate = new DateOnly(2024, 9, 13), CustomerId = 3, DishId = 4 },
            new RatingDish { RatingNumber = 2, RatingDate = new DateOnly(2024, 9, 14), CustomerId = 4, DishId = 5 },
            new RatingDish { RatingNumber = 5, RatingDate = new DateOnly(2024, 9, 15), CustomerId = 5, DishId = 6 },
            new RatingDish { RatingNumber = 3, RatingDate = new DateOnly(2024, 9, 16), CustomerId = 6, DishId = 7 },
            new RatingDish { RatingNumber = 4, RatingDate = new DateOnly(2024, 9, 17), CustomerId = 7, DishId = 8 },
            new RatingDish { RatingNumber = 5, RatingDate = new DateOnly(2024, 9, 18), CustomerId = 8, DishId = 9 },
            new RatingDish { RatingNumber = 2, RatingDate = new DateOnly(2024, 9, 19), CustomerId = 9, DishId = 10 },
            new RatingDish { RatingNumber = 4, RatingDate = new DateOnly(2024, 9, 20), CustomerId = 10, DishId = 1 }
        );

        dataContext.Orders.AddRange(
                new Order { OrderNumber = 1001, OrderDate = new DateOnly(2024, 9, 1), OrderStatus = 1, OrderNullified = 0, CustomerId = 1 },
                new Order { OrderNumber = 1002, OrderDate = new DateOnly(2024, 9, 2), OrderStatus = 0, OrderNullified = 0, CustomerId = 2 },
                new Order { OrderNumber = 1003, OrderDate = new DateOnly(2024, 9, 3), OrderStatus = 2, OrderNullified = 1, CustomerId = 3 },
                new Order { OrderNumber = 1004, OrderDate = new DateOnly(2024, 9, 4), OrderStatus = 1, OrderNullified = 0, CustomerId = 4 },
                new Order { OrderNumber = 1005, OrderDate = new DateOnly(2024, 9, 5), OrderStatus = 2, OrderNullified = 0, CustomerId = 5 },
                new Order { OrderNumber = 1006, OrderDate = new DateOnly(2024, 9, 6), OrderStatus = 0, OrderNullified = 0, CustomerId = 6 },
                new Order { OrderNumber = 1007, OrderDate = new DateOnly(2024, 9, 7), OrderStatus = 1, OrderNullified = 1, CustomerId = 7 },
                new Order { OrderNumber = 1008, OrderDate = new DateOnly(2024, 9, 8), OrderStatus = 2, OrderNullified = 0, CustomerId = 8 },
                new Order { OrderNumber = 1009, OrderDate = new DateOnly(2024, 9, 9), OrderStatus = 0, OrderNullified = 0, CustomerId = 9 },
                new Order { OrderNumber = 1010, OrderDate = new DateOnly(2024, 9, 10), OrderStatus = 1, OrderNullified = 0, CustomerId = 10 },
                new Order { OrderNumber = 1011, OrderDate = new DateOnly(2024, 9, 11), OrderStatus = 2, OrderNullified = 0, CustomerId = 1 },
                new Order { OrderNumber = 1012, OrderDate = new DateOnly(2024, 9, 12), OrderStatus = 0, OrderNullified = 0, CustomerId = 2 },
                new Order { OrderNumber = 1013, OrderDate = new DateOnly(2024, 9, 13), OrderStatus = 1, OrderNullified = 1, CustomerId = 3 },
                new Order { OrderNumber = 1014, OrderDate = new DateOnly(2024, 9, 14), OrderStatus = 2, OrderNullified = 0, CustomerId = 4 },
                new Order { OrderNumber = 1015, OrderDate = new DateOnly(2024, 9, 15), OrderStatus = 0, OrderNullified = 0, CustomerId = 5 },
                new Order { OrderNumber = 1016, OrderDate = new DateOnly(2024, 9, 16), OrderStatus = 1, OrderNullified = 0, CustomerId = 6 },
                new Order { OrderNumber = 1017, OrderDate = new DateOnly(2024, 9, 17), OrderStatus = 2, OrderNullified = 0, CustomerId = 7 },
                new Order { OrderNumber = 1018, OrderDate = new DateOnly(2024, 9, 18), OrderStatus = 1, OrderNullified = 1, CustomerId = 8 },
                new Order { OrderNumber = 1019, OrderDate = new DateOnly(2024, 9, 19), OrderStatus = 0, OrderNullified = 0, CustomerId = 9 },
                new Order { OrderNumber = 1020, OrderDate = new DateOnly(2024, 9, 20), OrderStatus = 2, OrderNullified = 0, CustomerId = 10 }
            );

        dataContext.SaveChanges();

        dataContext.OrderDishes.AddRange(
        new OrderDish { OrderQuantity = 3, OrderId = 1, DishId = 4 },
            new OrderDish { OrderQuantity = 1, OrderId = 2, DishId = 7 },
            new OrderDish { OrderQuantity = 4, OrderId = 3, DishId = 2 },
            new OrderDish { OrderQuantity = 2, OrderId = 4, DishId = 5 },
            new OrderDish { OrderQuantity = 5, OrderId = 15, DishId = 8 },
            new OrderDish { OrderQuantity = 2, OrderId = 16, DishId = 1 },
            new OrderDish { OrderQuantity = 3, OrderId = 7, DishId = 6 },
            new OrderDish { OrderQuantity = 1, OrderId = 14, DishId = 10 },
            new OrderDish { OrderQuantity = 4, OrderId = 9, DishId = 3 },
            new OrderDish { OrderQuantity = 2, OrderId = 10, DishId = 9 },
            new OrderDish { OrderQuantity = 1, OrderId = 11, DishId = 2 },
            new OrderDish { OrderQuantity = 5, OrderId = 12, DishId = 8 },
            new OrderDish { OrderQuantity = 3, OrderId = 3, DishId = 4 },
            new OrderDish { OrderQuantity = 2, OrderId = 14, DishId = 7 },
            new OrderDish { OrderQuantity = 4, OrderId = 15, DishId = 5 },
            new OrderDish { OrderQuantity = 1, OrderId = 16, DishId = 10 },
            new OrderDish { OrderQuantity = 3, OrderId = 17, DishId = 6 },
            new OrderDish { OrderQuantity = 2, OrderId = 8, DishId = 1 },
            new OrderDish { OrderQuantity = 5, OrderId = 19, DishId = 9 },
            new OrderDish { OrderQuantity = 1, OrderId = 20, DishId = 2 },
            new OrderDish { OrderQuantity = 4, OrderId = 1, DishId = 3 },
            new OrderDish { OrderQuantity = 2, OrderId = 2, DishId = 6 },
            new OrderDish { OrderQuantity = 5, OrderId = 3, DishId = 8 },
            new OrderDish { OrderQuantity = 3, OrderId = 14, DishId = 4 },
            new OrderDish { OrderQuantity = 1, OrderId = 5, DishId = 7 },
            new OrderDish { OrderQuantity = 2, OrderId = 6, DishId = 5 },
            new OrderDish { OrderQuantity = 4, OrderId = 12, DishId = 10 },
            new OrderDish { OrderQuantity = 3, OrderId = 8, DishId = 9 },
            new OrderDish { OrderQuantity = 2, OrderId = 9, DishId = 1 },
            new OrderDish { OrderQuantity = 5, OrderId = 1, DishId = 8 },
            new OrderDish { OrderQuantity = 1, OrderId = 11, DishId = 3 },
            new OrderDish { OrderQuantity = 4, OrderId = 12, DishId = 6 },
            new OrderDish { OrderQuantity = 2, OrderId = 13, DishId = 7 },
            new OrderDish { OrderQuantity = 3, OrderId = 14, DishId = 5 },
            new OrderDish { OrderQuantity = 1, OrderId = 15, DishId = 10 },
            new OrderDish { OrderQuantity = 4, OrderId = 16, DishId = 2 },
            new OrderDish { OrderQuantity = 2, OrderId = 17, DishId = 8 },
            new OrderDish { OrderQuantity = 5, OrderId = 8, DishId = 4 },
            new OrderDish { OrderQuantity = 3, OrderId = 19, DishId = 9 },
            new OrderDish { OrderQuantity = 1, OrderId = 20, DishId = 6 }
        );
        dataContext.SaveChanges();
    }
}
static Customer CreateCustomer(int id, string firstName, string lastName, string email, string phone, string password)
{
    string salt = GenerateSalt();
    string hashedPassword = GenerateHash(salt, password);
    return new Customer
    {
        CustomerName = firstName,
        CustomerSurname = lastName,
            CustomerEmail = email,
            CustomerPhone = phone,
            CustomerPassHash = hashedPassword,
            CustomerPassSalt = salt,
            CustomerDateRegister = DateOnly.FromDateTime(DateTime.Now.AddDays(-id * 10)),
            CustomerStatus = (byte)(id % 2 == 0 ? 1 : 0)
        };
    }

    app.Run();


    static string GenerateSalt()
    {
        int saltSize = 16;

        byte[] saltBytes = new byte[saltSize];

        using (var rng = new RNGCryptoServiceProvider())
        {
            rng.GetBytes(saltBytes);
        }

        return Convert.ToBase64String(saltBytes);
    }

    static string GenerateHash(string salt, string password)
    {
        string saltedPassword = salt + password;

        using (var sha256 = SHA256.Create())
        {
            byte[] saltedPasswordBytes = Encoding.UTF8.GetBytes(saltedPassword);
            byte[] hashBytes = sha256.ComputeHash(saltedPasswordBytes);

            // Convert the hash byte array to a base64 string
            return Convert.ToBase64String(hashBytes);
        }
    }

