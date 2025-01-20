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

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CarDao get carDao {
    return _carDaoInstance ??= _$CarDao(database, changeListener);
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
  Future<List<Car>> findAllCars() async {
    return _queryAdapter.queryList('SELECT * FROM Car',
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
            latitude: row['latitude'] as double));
  }

  @override
  Future<void> insertCars(List<Car> cars) async {
    await _carInsertionAdapter.insertList(cars, OnConflictStrategy.replace);
  }
}
