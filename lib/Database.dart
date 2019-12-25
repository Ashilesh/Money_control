import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart'; //for join method
import 'dart:convert';

class DBProvider {
  // private constructor class_name._();
  // for singleton pattern
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    print('in database');
    _database = await initDB();
    return _database;
  }

  // initialize database if _database object is null
  // _database object is used in newClient() and getClient() method
  // when we call newClient() method for first time or getClient() method
  // then this function gets executed for only once
  // when we start the app
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");

    print("in initDB");

    return await openDatabase(path, version: 1, onOpen: (db){},
        onCreate: (Database db, int version) async{
          await db.execute("Create table Client ("
              "id integer,"
              "first_name Text,"
              "last_name Text,"
              "blocked BIT"
              ")");
        }
    );
  }

  newClient(Client newClient) async{

    print('new Client');
    final db = await database;
    print('down database');
    var res = await db.rawInsert(
        "insert into Client (id,first_name) values(${newClient.id},'${newClient.firstName}')"
    );


    var res1 = await db.query("Client", where: "id = ?", whereArgs: [3]);

    Client dumC = Client.fromMap(res1.first);

    print('${dumC.firstName}');
    return res;
  }

  getClient(int id) async{
    final db = await database;
    var res = await db.query("Client", where: "id = ?", whereArgs: [id]);

    return res.isNotEmpty ? Client.fromMap(res.first) : Null;
  }
}

// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);
// link: https://app.quicktype.io/#l=dart

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int id;
  String firstName;
  String lastName;
  bool blocked;

  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.blocked,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    blocked: json["blocked"] == 1,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "blocked": blocked,
  };
}