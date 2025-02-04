// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CarDao? _carDaoInstance;

  CustomerDao? _customerDaoInstance;

  RentalDao? _rentalDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Car` (`id` INTEGER NOT NULL, `brand` TEXT NOT NULL, `model` TEXT NOT NULL, `picture` TEXT NOT NULL, `pictureContentType` TEXT NOT NULL, `fuel` TEXT NOT NULL, `options` TEXT NOT NULL, `licensePlate` TEXT NOT NULL, `engineSize` INTEGER NOT NULL, `modelYear` INTEGER NOT NULL, `since` TEXT NOT NULL, `price` INTEGER NOT NULL, `nrOfSeats` INTEGER NOT NULL, `body` TEXT NOT NULL, `longitude` REAL NOT NULL, `latitude` REAL NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Customer` (`id` INTEGER NOT NULL, `nr` INTEGER NOT NULL, `lastName` TEXT NOT NULL, `firstName` TEXT NOT NULL, `from` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `RentalDatabase` (`id` INTEGER, `code` TEXT NOT NULL, `longitude` REAL NOT NULL, `latitude` REAL NOT NULL, `fromDate` TEXT NOT NULL, `toDate` TEXT NOT NULL, `state` TEXT NOT NULL, `carId` INTEGER NOT NULL, `customerId` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CarDao get carDao {
    return _carDaoInstance ??= _$CarDao(database, changeListener);
  }

  @override
  CustomerDao get customerDao {
    return _customerDaoInstance ??= _$CustomerDao(database, changeListener);
  }

  @override
  RentalDao get rentalDao {
    return _rentalDaoInstance ??= _$RentalDao(database, changeListener);
  }
}

class _$CarDao extends CarDao {
  _$CarDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _carInsertionAdapter = InsertionAdapter(
            database,
            'Car',
            (Car item) => <String, Object?>{
                  'id': item.id,
                  'brand': item.brand,
                  'model': item.model,
                  'picture': item.picture,
                  'pictureContentType': item.pictureContentType,
                  'fuel': item.fuel,
                  'options': item.options,
                  'licensePlate': item.licensePlate,
                  'engineSize': item.engineSize,
                  'modelYear': item.modelYear,
                  'since': item.since,
                  'price': item.price,
                  'nrOfSeats': item.nrOfSeats,
                  'body': item.body,
                  'longitude': item.longitude,
                  'latitude': item.latitude
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Car> _carInsertionAdapter;

  @override
  Future<List<Car>> getCarsByPage(
    int offset,
    int pageSize,
  ) async {
    return _queryAdapter.queryList('SELECT * FROM Car LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => Car(
            id: row['id'] as int,
            brand: row['brand'] as String,
            model: row['model'] as String,
            picture: row['picture'] as String,
            pictureContentType: row['pictureContentType'] as String,
            fuel: row['fuel'] as String,
            options: row['options'] as String,
            licensePlate: row['licensePlate'] as String,
            engineSize: row['engineSize'] as int,
            modelYear: row['modelYear'] as int,
            since: row['since'] as String,
            price: row['price'] as int,
            nrOfSeats: row['nrOfSeats'] as int,
            body: row['body'] as String,
            longitude: row['longitude'] as double,
            latitude: row['latitude'] as double),
        arguments: [offset, pageSize]);
  }

  @override
  Future<Car?> getCarById(int id) async {
    return _queryAdapter.query('SELECT * FROM Car WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Car(
            id: row['id'] as int,
            brand: row['brand'] as String,
            model: row['model'] as String,
            picture: row['picture'] as String,
            pictureContentType: row['pictureContentType'] as String,
            fuel: row['fuel'] as String,
            options: row['options'] as String,
            licensePlate: row['licensePlate'] as String,
            engineSize: row['engineSize'] as int,
            modelYear: row['modelYear'] as int,
            since: row['since'] as String,
            price: row['price'] as int,
            nrOfSeats: row['nrOfSeats'] as int,
            body: row['body'] as String,
            longitude: row['longitude'] as double,
            latitude: row['latitude'] as double),
        arguments: [id]);
  }

  @override
  Future<void> insertCars(List<Car> cars) async {
    await _carInsertionAdapter.insertList(cars, OnConflictStrategy.replace);
  }
}

class _$CustomerDao extends CustomerDao {
  _$CustomerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _customerInsertionAdapter = InsertionAdapter(
            database,
            'Customer',
            (Customer item) => <String, Object?>{
                  'id': item.id,
                  'nr': item.nr,
                  'lastName': item.lastName,
                  'firstName': item.firstName,
                  'from': item.from
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Customer> _customerInsertionAdapter;

  @override
  Future<List<Customer>> getAllCustomers() async {
    return _queryAdapter.queryList('SELECT * FROM Customer',
        mapper: (Map<String, Object?> row) => Customer(
            id: row['id'] as int,
            nr: row['nr'] as int,
            lastName: row['lastName'] as String,
            firstName: row['firstName'] as String,
            from: row['from'] as String));
  }

  @override
  Future<Customer?> getCustomerById(int id) async {
    return _queryAdapter.query('SELECT * FROM Customer WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Customer(
            id: row['id'] as int,
            nr: row['nr'] as int,
            lastName: row['lastName'] as String,
            firstName: row['firstName'] as String,
            from: row['from'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertCustomer(Customer customer) async {
    await _customerInsertionAdapter.insert(
        customer, OnConflictStrategy.replace);
  }
}

class _$RentalDao extends RentalDao {
  _$RentalDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _rentalDatabaseInsertionAdapter = InsertionAdapter(
            database,
            'RentalDatabase',
            (RentalDatabase item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'longitude': item.longitude,
                  'latitude': item.latitude,
                  'fromDate': item.fromDate,
                  'toDate': item.toDate,
                  'state': item.state,
                  'carId': item.carId,
                  'customerId': item.customerId
                }),
        _rentalDatabaseDeletionAdapter = DeletionAdapter(
            database,
            'RentalDatabase',
            ['id'],
            (RentalDatabase item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'longitude': item.longitude,
                  'latitude': item.latitude,
                  'fromDate': item.fromDate,
                  'toDate': item.toDate,
                  'state': item.state,
                  'carId': item.carId,
                  'customerId': item.customerId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RentalDatabase> _rentalDatabaseInsertionAdapter;

  final DeletionAdapter<RentalDatabase> _rentalDatabaseDeletionAdapter;

  @override
  Future<List<RentalDatabase>> getAllRentals() async {
    return _queryAdapter.queryList('SELECT * FROM RentalDatabase',
        mapper: (Map<String, Object?> row) => RentalDatabase(
            id: row['id'] as int?,
            code: row['code'] as String,
            longitude: row['longitude'] as double,
            latitude: row['latitude'] as double,
            fromDate: row['fromDate'] as String,
            toDate: row['toDate'] as String,
            state: row['state'] as String,
            carId: row['carId'] as int,
            customerId: row['customerId'] as int));
  }

  @override
  Future<RentalDatabase?> getRentalById(int id) async {
    return _queryAdapter.query('SELECT * FROM RentalDatabase WHERE id = ?1',
        mapper: (Map<String, Object?> row) => RentalDatabase(
            id: row['id'] as int?,
            code: row['code'] as String,
            longitude: row['longitude'] as double,
            latitude: row['latitude'] as double,
            fromDate: row['fromDate'] as String,
            toDate: row['toDate'] as String,
            state: row['state'] as String,
            carId: row['carId'] as int,
            customerId: row['customerId'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertRental(RentalDatabase rental) async {
    await _rentalDatabaseInsertionAdapter.insert(
        rental, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteRental(RentalDatabase rental) async {
    await _rentalDatabaseDeletionAdapter.delete(rental);
  }
}
