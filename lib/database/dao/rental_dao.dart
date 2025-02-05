import 'package:floor/floor.dart';
import 'package:automaat_app/database/model/rental_database_model.dart';

@dao
abstract class RentalDao {
  @Query('SELECT * FROM RentalDatabase')
  Future<List<RentalDatabase>> getAllRentals();

  @Query('SELECT * FROM RentalDatabase WHERE id = :id')
  Future<RentalDatabase?> getRentalById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRental(RentalDatabase rental);

  @Query('DELETE FROM RentalDatabase')
  Future<void> clearTable();

  @delete
  Future<void> deleteRental(RentalDatabase rental);
}