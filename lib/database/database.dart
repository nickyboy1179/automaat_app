import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:automaat_app/database/model/rental_database_model.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/model/rest_model/customer_model.dart';

import 'package:automaat_app/database/dao/dao.dart';

part 'database.g.dart';

@Database(
    version:1,
    entities: [Car, Customer, RentalDatabase]
)
abstract class AppDatabase extends FloorDatabase {
  CarDao get carDao;
  CustomerDao get customerDao;
  RentalDao get rentalDao;
}