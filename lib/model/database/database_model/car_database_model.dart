import 'package:floor/floor.dart';

@dao
abstract class CarDao {

  @Insert
  Future<void> insertCar(CarModel)
}