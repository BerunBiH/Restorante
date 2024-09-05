import 'package:erestorante_mobile/models/commentDish.dart';
import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/models/ratingDishes.dart';
import 'package:erestorante_mobile/models/ratingStaffs.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';

class RatingStaffProvider extends BaseProvider<RatingStaffs>{
  RatingStaffProvider(): super("RatingStaff");

  @override
  RatingStaffs fromJson(data) {
    return RatingStaffs.fromJson(data);
  }
}