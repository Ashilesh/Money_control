import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart'; //for join method
import 'dart:convert';
import 'Database.dart';

class DBLog{

  DBLog._();

  static final db = DBLog._();

  static Database _database;

  Future<Database> get database async{
    if(_database != null)
      return _database;

    _database = await initDB();

    print('return DB');
    return _database;
  }

  initDB()async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "Log.db");

    print('in initDB');
    return await openDatabase(path,version: 1,onOpen: (db){print('Open db');},
    onCreate: (Database db, int version)async{
      await db.execute("create table LogTable ("
          "id integer,"
          "amount integer,"
          "reason Text,"
          "time_stamp datetime default CURRENT_TIMESTAMP"
          ")");
    }
    );
  }

  newLog(Log logData)async{
    print('in new');
    final db = await database;

    print('insertion started!');
    var res = await db.rawInsert("Insert into LogTable (id,amount,reason) values(${logData.id},${logData.amount},'${logData.reason}')");

    var res2 = await DBProvider.db.updateAmount(logData.id, logData.amount);

    print('res2 : $res2');
    print('insertion compelted!');
    return res;
  }

  getLogs(int id)async{
    final db = await database;

    var count = db.rawQuery("SELECT * FROM LogTable where id = $id");

    return count;
  }

  deleteAll()async{
    final db = await database;

    var count = db.rawQuery("Delete from LogTable");

    return count;
  }
}



Log logFromJson(String str) => Log.fromJson(json.decode(str));

String logToJson(Log data) => json.encode(data.toJson());

class Log {
  int id;
  int amount;
  String reason;

  Log({
    this.id,
    this.amount,
    this.reason,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
    id: json["id"],
    amount: json["amount"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "reason": reason,
  };

}