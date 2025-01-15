import 'package:floor/floor.dart';
import '../../rest_model/car_model.dart';

@dao
abstract class CarDao {

  @Query('SELECT * FROM Car')
  Future<List<Car>> findAllCars();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCars(List<Car> cars);
}