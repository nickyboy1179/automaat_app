import 'package:floor/floor.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';

@dao
abstract class CarDao {

  @Query('SELECT * FROM Car LIMIT :pageSize OFFSET :offset')
  Future<List<Car>> getCarsByPage(int offset, int pageSize);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCars(List<Car> cars);
}