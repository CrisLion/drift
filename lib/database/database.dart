import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'database.g.dart';


class User extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text()();
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'dbUser.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [User])
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;


  //Crear metodos CRUD
  Future<List<UserData>> getListUsers() async {
    return await select(user).get();
  }

  Future<int> insertUser(UserCompanion userCompanion) async {
    return await into(user).insert(userCompanion);
  }

  Future<int> deleteUser(UserCompanion userCompanion) async {
    return await delete(user).delete(userCompanion);
  }

  Future<bool> updateUser(UserCompanion usersCompanion) async{
    return await update(user).replace(usersCompanion);
  }
}
