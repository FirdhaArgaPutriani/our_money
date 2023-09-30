import 'package:our_money/model/money.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;

class DataBase {
  static final DataBase _instance = DataBase.internal();
  DataBase.internal();

  factory DataBase() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'our-money.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE money(id INTEGER PRIMARY KEY, tanggal STRING, nominal INTEGER, keterangan TEXT, tipe STRING)',
    );

    await db.execute(
      'CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, username STRING, password STRING)',
    );

    await db.rawInsert(
      "INSERT INTO user (name, username, password) VALUES ('user', 'user', 'user')",
    );
    print('MySQLite DB Created');
  }

  Future<Map<String, dynamic>> getLogin(
      String username, String password) async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient!.query(
      'user',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (res.isNotEmpty) {
      return res[0];
    } else {
      return {};
    }
  }

  Future<String> getPassword() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery(
      "SELECT password FROM user WHERE username = 'user'",
    );
    String password = list[0]['password'].toString();
    return password;
  }

  Future<bool> updatePassword(String password) async {
    var dbClient = await db;
    int res = await dbClient!.rawUpdate(
      "UPDATE user SET password = '$password' WHERE username = 'user'",
    );
    return res > 0 ? true : false;
  }

  Future<int> saveMoney(Money money) async {
    var dbClient = await db;
    int res = await dbClient!.insert('money', money.toMap());
    print('Money saved');
    return res;
  }

  Future<List<Money>> getMoney() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery("SELECT * FROM money");
    List<Money> moneyList = [];
    for (int i = 0; i < list.length; i++) {
      var money = Money(
        list[i]['tanggal'],
        list[i]['nominal'],
        list[i]['keterangan'],
        list[i]['tipe'],
      );
      money.setMoneyId(list[i]['id']);
      moneyList.add(money);
    }
    print(moneyList);
    return moneyList;
  }

  Future<int> getTotalNominalByType(String type) async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery(
        "SELECT SUM(nominal) as total_nominal FROM money WHERE tipe = '$type'");

    if (list.isNotEmpty && list[0]['total_nominal'] != null) {
      int totalNominal = int.parse(list[0]['total_nominal'].toString());
      return totalNominal;
    } else {
      return 0;
    }
  }

  Future<bool> updateMoney(Money money) async {
    var dbClient = await db;
    int res = await dbClient!.update(
      'money',
      money.toMap(),
      where: 'id=?',
      whereArgs: <int>[money.id],
    );
    return res > 0 ? true : false;
  }

  Future<int> deleteMoney(Money money) async {
    var dbClient = await db;
    int res = await dbClient!.rawDelete(
      'DELETE FROM money WHERE id= ?',
      [money.id],
    );
    return res;
  }
}
