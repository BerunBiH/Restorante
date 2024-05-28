using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using eRestorante.Services.Services;
using eRestoranteAPI.Authentication;
using eRestoranteAPI.Filters;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddSwaggerGen(options =>
{
    options.CustomSchemaIds(type => type.ToString());
});

builder.Services.AddTransient<IDishesService, DishService>();
builder.Services.AddTransient<IRoleService, RoleService>();
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<IOrderService, OrderService>();
builder.Services.AddTransient<IDrinkService, DrinkService>();
builder.Services.AddTransient<ICustomerService, CustomerService>();
builder.Services.AddTransient<ICategoryService, CategoryService>();
builder.Services.AddTransient<IOrderDishesService, OrderDishesService>();
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

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<Ib200192Context>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(IUserService));
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

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

app.Run();
