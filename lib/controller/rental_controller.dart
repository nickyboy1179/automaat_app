import 'package:automaat_app/database/model/rental_database_model.dart';
import 'package:automaat_app/model/rest_model/customer_model.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'package:automaat_app/service/locator.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';
import 'package:automaat_app/model/rest_model/about_me_model.dart';
import 'package:automaat_app/database/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';

class RentalController {
  final _restClient = locator<RestClient>();
  final _database = locator<AppDatabase>();

  Future<List<Rental>> getUserRentals(BuildContext context) async {
    NetworkStateProvider networkStateProvider =
        Provider.of<NetworkStateProvider>(context);

    if (networkStateProvider.isConnected) {
      AboutMe userInfo = await _getAboutMe();
      String customerId = "${userInfo.id}";
      List<Rental> rentals = await _getRentalsByCustomerIdNetwork(customerId);
      return rentals;
    } else {
      return _getRentalsFromDatabase();
    }
  }

  Future<AboutMe> _getAboutMe() async {
    AboutMe me = await _restClient.getUserInfo();
    Customer customer = Customer(
      id: me.id,
      nr: me.nr,
      lastName: me.lastName,
      firstName: me.firstName,
      from: me.from,
    );
    await _database.customerDao.insertCustomer(customer);
    return me;
  }

  Future<List<Rental>> _getRentalsByCustomerIdNetwork(String id) async {
    List<Rental> rentals =
        await _restClient.getRentalsByCustomerId(id, "0", "20");

    for (Rental rental in rentals) {
      RentalDatabase rentalDatabase = RentalDatabase(
        id: rental.id,
        code: rental.code,
        longitude: rental.longitude,
        latitude: rental.latitude,
        fromDate: rental.fromDate,
        toDate: rental.toDate,
        state: rental.state,
        carId: rental.car.id,
        customerId: rental.customer.id,
      );
      await _database.rentalDao.insertRental(rentalDatabase);
    }
    return rentals;
  }

  Future<Customer?> _getCustomerFromDatabase() async {
    List<Customer> customers = await _database.customerDao.getAllCustomers();
    if (customers.isEmpty) return null;
    return customers[0];
  }

  Future<List<Rental>> _getRentalsFromDatabase() async {
    List<RentalDatabase> rentalsDatabase =
        await _database.rentalDao.getAllRentals();
    Customer? customer = await _getCustomerFromDatabase();

    if (customer == null) return [];

    List<Rental> rentals = [];
    for (RentalDatabase rentalDatabase in rentalsDatabase) {
      Car? car = await _database.carDao.getCarById(rentalDatabase.carId);

      if (car == null) continue;

      Rental rental = Rental(
          id: rentalDatabase.id,
          code: rentalDatabase.code,
          longitude: rentalDatabase.longitude,
          latitude: rentalDatabase.latitude,
          fromDate: rentalDatabase.fromDate,
          toDate: rentalDatabase.toDate,
          state: rentalDatabase.state,
          customer: customer,
          car: car);
      rentals.add(rental);
    }

    return rentals;
  }
}
