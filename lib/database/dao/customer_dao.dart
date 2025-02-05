import 'package:floor/floor.dart';
import 'package:automaat_app/model/rest_model/customer_model.dart';

@dao
abstract class CustomerDao {
  @Query('SELECT * FROM Customer')
  Future<List<Customer>> getAllCustomers();

  @Query('SELECT * FROM Customer WHERE id = :id')
  Future<Customer?> getCustomerById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCustomer(Customer customer);

  @Query('DELETE FROM Customer')
  Future<void> clearTable();
}