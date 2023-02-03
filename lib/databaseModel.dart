import 'dart:io';


import 'package:bmicalculator/recordModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHeleper{

  static const dbName="records.db";
  static const dbVersion=1;
  //singletone class
  DbHeleper._();
  static final instance=DbHeleper._();

  Database? _database;

  Future<Database?> get database async{
    if(_database !=null)return _database;
     _database=await initDatabase();
     return _database;
  }
  initDatabase()async{
    Directory dataDirectory= await getApplicationDocumentsDirectory();
    String dbPath =dataDirectory.path+dbName;
    return await openDatabase(dbPath,version: dbVersion,onCreate: _createDb);
  }
  _createDb(Database db,int version)async{
    await db.execute('''
  CREATE TABLE ${Record.tblRecords}(
    ${Record.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Record.colName} TEXT NOT NULL,
    ${Record.colBmi} REAL NOT NULL
  )
''');
  }
  Future <int> InsertRecord(Record record)async{
    Database? db =await database;
    return await db!.insert(Record.tblRecords, record.toMap());
  }
  Future<int> deleteRecord (int id)async{
    Database? db = await database;
    return await db!.delete(Record.tblRecords,where: "${Record.colId}==?",whereArgs: [id]);
  }

  Future<List<Record>> getRecord()async{
    Database? db= await database;
    List<Map<String,dynamic>> records= await db!.query(Record.tblRecords);
    return records.length==0 ? [] : records.map((e) => Record.fromMap(e)).toList();
  }
}