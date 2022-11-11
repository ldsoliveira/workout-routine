import 'package:sembast/sembast.dart';
import 'package:workout_routine/core/utils/app_database.dart';
import 'package:workout_routine/core/utils/constants.dart';
import 'package:workout_routine/features/routine/data/models/user_model.dart';

class UserDao {
  final _exercisesFolder = intMapStoreFactory.store(Constants.dbUserFolderName);

  Future<Database> get _db async => AppDatabase.instance.database;

  Future updateUser(UserModel user) async {
    final finder = Finder(filter: Filter.byKey(user.id));
    await _exercisesFolder.update(await _db, user.toJson(), finder: finder);
  }

  Future removeUser(UserModel user) async {
    final finder = Finder(filter: Filter.byKey(user.id));
    await _exercisesFolder.delete(await _db, finder: finder);
  }

  Future<UserModel> getUser() async {
    final recordSnapshot = await _exercisesFolder.find(await _db);
    return UserModel.fromJson(recordSnapshot.first.value);
  }
}