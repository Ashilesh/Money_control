import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String table = 'Transactions';
final String columnid = 'id';
final String columnamount = 'amount';

class Transaction{
    int id;
    int amount;

    Transaction();

    Transaction.fromMap(Map<String,dynamic> map){
      id = map[columnid];
      amount = map[columnamount];
    }

    Map<String, dynamic> toMap(){
      var map = <String, dynamic>{
        columnid : id,
        columnamount : amount
      };

      if (id != null)
        map[columnid] = id;

      return map;
    }
}

class DatabaseHelper{

  static final _databasename = 'Mydb.db';

  static final _databaseversion = 1;

  DatabaseHelper._privateConstructor();

 static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

 static Database _database;

 Future<Database> get database async{

   if(_database != null)
     return _database;

   _database = await _initDatabase();

   return _database;
 }

 _initDatabase() async{
   Directory documentDirectory = await getApplicationDocumentsDirectory();
   String path = join(documentDirectory.path,_databasename);

   return await openDatabase(path,
     version: _databaseversion,
     onCreate: _onCreate
   );
 }

 Future _onCreate(Database db,int version) async{
   await db.execute('''
     CREATE TABLE $table(
     $columnid INTEGER PRIMARY KEY,
     $columnamount INTEGER NOT NULL
     )
     '''
   );}

   Future<int> insert(Transaction trans) async{

     Database db = await database;

     int id = await db.insert(table, trans.toMap());

     return id;
   }

   Future<Transaction> queryTrans(int id) async{
     Database db = await database;

     List<Map> maps = await db.query(table, columns: [columnid,columnamount],where: '$columnid = ?', whereArgs: [id]);


     if(maps.length > 0)
       return Transaction.fromMap(maps.first);
     return null;
   }
 }
