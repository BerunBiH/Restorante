using eRestorante.Services.Database;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using eRestorante.Models.Requests;
using System.Security.Cryptography;
using Microsoft.EntityFrameworkCore;
using eRestorante.Services.Interfaces;
using eRestorante.Models.SearchObjects;
using eRestorante.Models.Model;

namespace eRestorante.Services.Services
{
    public class OrderService : BaseCRUDService<Models.Model.Order, Database.Order, Models.SearchObjects.OrderSearchObject, OrderInsertRequest, OrderUpdateRequest>, IOrderService
    {

        public OrderService(Ib200192Context context, IMapper mapper)
            :base(context,mapper)
        {
        }

        public override IQueryable<Database.Order> AddFilter(IQueryable<Database.Order> query, OrderSearchObject? search = null)
        {
            if (search?.OrderNumber!=0 && search?.OrderNumber != null)
            {
                query = query.Where(x => x.OrderNumber==search.OrderNumber);
            }

            else if (search?.OrderDate != DateOnly.MinValue && search?.OrderDate != null)
            {
                query = query.Where(x => x.OrderDate==search.OrderDate);
            }

            else if (search?.CustomerId!=null)
            {
                query = query.Where(x => x.CustomerId == search.CustomerId);
            }

            return base.AddFilter(query, search);
        }

        public override async Task<Task> BeforeInsert(Database.Order entity, OrderInsertRequest request)
        {
            DateOnly currentDate = DateOnly.FromDateTime(DateTime.Now);
            entity.OrderDate = currentDate;

            entity.OrderNullified = 0;
            entity.OrderStatus = 0;

            int dateCalc = (currentDate.Year * 100000) + (currentDate.Month * 1000) + (currentDate.Day * 10);

            var orders = _context.Orders;
            var orderCount= await orders.CountAsync();
            if (orderCount > 0)
            {
                var listOrders=orders.OrderByDescending(o => o.OrdersId);
                var lastOrder = await listOrders.FirstOrDefaultAsync();
                if (lastOrder != null && lastOrder.OrderDate == currentDate)
                {
                    var orderNumString = lastOrder.OrderNumber.ToString();
                    orderNumString=orderNumString.Substring(8);
                    var orderNum = int.Parse(orderNumString);
                    if (orderNum > 1)
                    {
                        dateCalc *= numDecimals(orderNum);
                    }
                    entity.OrderNumber = dateCalc + orderNum+1;
                }
            }

            else
            {
                entity.OrderNumber = dateCalc + 1; 
            }
            return base.BeforeInsert(entity, request);
        }

        public override IQueryable<Database.Order> AddInclude(IQueryable<Database.Order> query, OrderSearchObject? search = null)
        {
            query = query.Include("OrderDishes.Dish");
            query = query.Include("OrderDrinks");
            return base.AddInclude(query, search);
        }

        private int numDecimals(int orderNumber)
        {
            int num = 1;
            
            while (orderNumber>=9)
            {
                orderNumber /= 10;
                num *= 10;
            }

            return num;
        }
    }
}
