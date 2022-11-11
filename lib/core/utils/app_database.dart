import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:workout_routine/core/utils/constants.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;

  late Database database;

  Future<Database> get db async {
    database = await _openDatabase();
    return database;
  }
  Future<Database> get clear async {
    database = await _clearDatabase();
    return database;
  }
  Database get databaseInstance {
    return database;
  }

  Future<Database> _openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, Constants.dbName);
    final db = await databaseFactoryIo.openDatabase(dbPath, codec: null);
    return db;
  }

  Future<Database> _clearDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, Constants.dbName);
    await databaseFactoryIo.deleteDatabase(dbPath);
    final db = await databaseFactoryIo.openDatabase(dbPath, codec: null);
    return db;
  }

}