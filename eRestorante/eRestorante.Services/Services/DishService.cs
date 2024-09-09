using AutoMapper;
using eRestorante.Models.Exceptions;
using eRestorante.Models.Model;
using eRestorante.Models.Requests;
using eRestorante.Models.SearchObjects;
using eRestorante.Services.Database;
using eRestorante.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestorante.Services.Services
{
    public class DishService : BaseCRUDService<Models.Model.Dishes, Database.Dish, Models.SearchObjects.DishSearchObject, Models.Requests.DishInsertRequest, Models.Requests.DishUpdateRequest>, IDishesService
    {
        public DishService(Ib200192Context context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override IQueryable<Dish> AddInclude(IQueryable<Dish> query, DishSearchObject? search = null)
        {
            query = query.Include("CommentDishes");
            query = query.Include("OrderDishes");
            query = query.Include("RatingDishes");

            return base.AddInclude(query, search);
        }

        public override Task BeforeUpdate(Dish db, DishUpdateRequest update)
        {
            if (update.DishCost <= 0)
            {
                throw new UserException("The cost of the dish can't be equal to or less than zero.");
                update.DishCost = db.DishCost;
            }

            return base.BeforeUpdate(db, update);

        }

        public override IQueryable<Dish> AddFilter(IQueryable<Dish> query, DishSearchObject? search = null)
        {

            if (!string.IsNullOrWhiteSpace(search?.DishName))
            {
                query = query.Where(x => x.DishName.Contains(search.DishName));
            }

            return base.AddFilter(query, search);
        }

        public override async Task<Task> BeforeRemove(Dish db)
        {
            var entityRatingD = await _context.RatingDishes.Where(x => x.DishId == db.DishId).ToListAsync();

            foreach (var rating in entityRatingD)
            {
                _context.RatingDishes.Remove(rating);

                await _context.SaveChangesAsync();
            }

            var entityCommentD = await _context.CommentDishes.Where(x => x.DishId == db.DishId).ToListAsync();

            foreach (var comment in entityCommentD)
            {
                _context.CommentDishes.Remove(comment);

                await _context.SaveChangesAsync();
            }

            var entityOrderD = await _context.OrderDishes.Where(x => x.DishId == db.DishId).ToListAsync();

            foreach (var orderD in entityOrderD)
            {
                _context.OrderDishes.Remove(orderD);

                await _context.SaveChangesAsync();
            }

            return base.BeforeRemove(db);
        }

        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public List<Models.Model.Dishes> Recommended(int id)
        {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    var tmpData = _context.Orders.Include("OrderDishes").ToList();

                    var data = new List<ProductEntry>();

                    int num = 0;
                    foreach (var x in tmpData)
                    {
                        if (x.OrderDishes.Count > 1)
                        {
                            var distinctItemId = x.OrderDishes.Select(y => y.DishId).ToList();

                            distinctItemId.ForEach(y =>
                            {
                                var relatedItems = x.OrderDishes.Where(z => z.DishId != y);

                                foreach (var z in relatedItems)
                                {
                                    data.Add(new ProductEntry()
                                    {
                                        ProductID = (uint)y,
                                        CoPurchaseProductID = (uint)z.DishId,
                                    });
                                }
                            });
                        }


                    }

                    if (data.Count==0)
                    {
                        return null;
                    }
                    var trainData = mlContext.Data.LoadFromEnumerable(data);

                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID);
                    options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID);
                    options.LabelColumnName = nameof(ProductEntry.Label);
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;
                    // For better results use the following parameters
                    options.NumberOfIterations = 100;
                    options.C = 0.00001;

                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(trainData);
                }

                if(model==null)
                {
                    return null;
                }

                var dishes = _context.Dishes.Where(x => x.DishId != id);

                var predictionResult = new List<Tuple<Database.Dish, float>>();

                foreach (var dish in dishes)
                {
                    var predictionengine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(model);
                    var prediction = predictionengine.Predict(
                    new ProductEntry()
                    {
                        ProductID = (uint)id,
                        CoPurchaseProductID = (uint)dish.DishId,
                    });

                    predictionResult.Add(new Tuple<Dish, float>(dish, prediction.Score));
                }

                var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(3).ToList();

                return _mapper.Map<List<Models.Model.Dishes>>(finalResult);
            }
        }

        public class Copurchase_prediction
        {
            public float Score { get; set; }
        }

        public class ProductEntry
        {
            [KeyType(count: 100)]
            public uint ProductID { get; set; }

            [KeyType(count: 100)]
            public uint CoPurchaseProductID { get; set; }

            public float Label { get; set; }
        }
    }

}


