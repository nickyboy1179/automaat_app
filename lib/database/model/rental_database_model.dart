import 'package:floor/floor.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/model/rest_model/customer_model.dart';

@entity
class RentalDatabase {
  @primaryKey
  final int? id;

  final String code;
  final double longitude;
  final double latitude;
  final String fromDate;
  final String toDate;
  final String state;

  @ForeignKey(
    entity: Car,
    parentColumns: ['id'],
    childColumns: ['carId'],
    onDelete: ForeignKeyAction.cascade,
  )
  final int carId;

  @ForeignKey(
    entity: Customer,
    parentColumns: ['id'],
    childColumns: ['customerId'],
    onDelete: ForeignKeyAction.cascade,
  )
  final int customerId;

  RentalDatabase({
    this.id,
    required this.code,
    required this.longitude,
    required this.latitude,
    required this.fromDate,
    required this.toDate,
    required this.state,
    required this.carId,
    required this.customerId,
  });
}
