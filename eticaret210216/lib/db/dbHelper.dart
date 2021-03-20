import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:eticaret210216/models/product.dart';

class dbHelper{
  String tblProduct = "product";
  String colId = "id";
  String colName= "name";
  String colPrice = "price";
  String colDescription = "description";
  String colStatus="status";
  String colQtyInStock="qtyInStock";
  String colSalesStartDate = "salesStartDate";

  static final dbHelper _dbHelper = dbHelper._internal();
  dbHelper._internal();

  factory dbHelper(){
    return _dbHelper;
  }

  static Database _db;
  Future<Database> get db async {
    if(_db == null ){
      _db = await dbCreate();
    }
    return _db;
  }

  Future<Database> dbCreate() async{

    Directory directory = await getApplicationDocumentsDirectory();
    var eTicaretDb = await openDatabase( directory.path + "ecoomerces.db" , version: 1 ,
        onCreate:  (Database database, int version) async {

        database.execute("Create table $tblProduct "
            "($colId integer primary key ,$colName text ,"
            "$colQtyInStock integer , $colSalesStartDate text, $colStatus text, $colDescription text, $colPrice double )");
    }
    );
    return eTicaretDb;
  }
  Future<int> insert(product product) async {
    Database db= await this.db;
    var resp= await db.insert(tblProduct, product.toMap());
    return resp;
  }

  Future<int> delete(int id) async {
    Database db= await this.db;
    var resp= await db.rawDelete("Delete from $tblProduct "
        "where $colId = $id");
    return resp;
  }
  Future<List> getProducts() async {
    Database db= await this.db;
    var resp= await db.rawQuery("Select * from $tblProduct");
    return resp;
  }
  Future<int> update (int id,product product1) async {
    Database db= await this.db;

    var a=db.update(tblProduct, product1.toMap(),where: "$colId = ?",whereArgs:[id] );
  }
}
