import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/car_dao.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';

part 'database.g.dart';

@Database(version:1, entities: [Car])
abstract class AppDatabase extends FloorDatabase {
  CarDao get carDao;
}