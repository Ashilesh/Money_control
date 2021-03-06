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
    String path = join(documentsDirectory.path, "Friend.db");

    print("in initDB");

    return await openDatabase(path, version: 1, onOpen: (db){},
        onCreate: (Database db, int version) async{
          await db.execute("Create table Client ("
              "id integer PRIMARY KEY AUTOINCREMENT,"
              "first_name Text,"
              "last_name Text,"
              "blocked BIT DEFAULT 0,"
              "image Text,"
              "amount integer DEFAULT 0"
              ")");
        }
    );
  }

  newClient(Client newClient) async{

    final db = await database;
    print('${newClient.image} image');
    var res = await db.rawInsert(
        "insert into Client (id,first_name,last_name,image) values(${newClient.id},'${newClient.firstName}',"
            "'${newClient.lastName}','${newClient.image}')"
    );

    print('completed insertion');

    return res;
  }

  Future<Client> getClient(int id) async{
    final db = await database;
    
    print('in getClient');
    var res = await db.query("Client", where: "id = ?", whereArgs: [id]);

    print("how something here");

    return res.isNotEmpty ? Client.fromMap(res.first) : null;
  }

  Future updateAmount(int id , int amount)async{
    final db = await database;

    var res = await db.rawQuery("Update Client set amount = amount + $amount where id = $id");

    return res;
  }

  Future updateBlocked(int id)async{
    final db = await database;

    var res = await db.rawQuery("Update Client set blocked = 1 where id = $id");

    return res;
  }
  
  Future getAll()async{
    final db = await database;

    var count = await db.rawQuery("SELECT * FROM Client where blocked = 0");

    return count;
  }
  
  Future deleteAll() async{
    final db = await database;
    
    var res = await db.rawQuery("Delete from Client");

    return res;
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
  String image;
  int amount;

  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.blocked,
    this.image,
    this.amount,
  });

  factory Client.fromMap(Map<String, dynamic> json) {

    return new Client(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      blocked: json["blocked"] == 1,
      image: json["image"],
      amount: json["amount"],
    );
  }
  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "blocked": blocked,
    "image": image,
    "amount": amount,
  };

  String show(){
    return "${this.id} ${this.firstName} ${this.lastName} ${this.image}";
  }
}