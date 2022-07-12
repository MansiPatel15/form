import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper
{
  Database db;

  Future<Database> create_db() async
  {
    if(db!=null)
      {
        return db;
      }
    else
      {
        Directory dir = await getApplicationDocumentsDirectory();
        String path = join(dir.path,"shopdb");
        var db= await openDatabase(path,version: 1,onCreate: create_table);
        return db;
      }
  }
  create_table(Database db,int version)async
  {
    db.execute("create table employee (eid integer primary key autoincrement,name text,dob text,designation text,qualification text,sex text,country text,email text,is_relocate text,mobile text)");
    print("table create");
  }
  Future<int> addEmployee(name,designation,qualification,operation,select,email,mobile,)async
  {
    var db = await create_db();
    var id = await db.rawInsert("insert into employee (name,designation,qualification,sex,country,email,mobile) values (?,?,?,?,?,?,?)",[name,designation,qualification,operation,select,email,mobile,]);
    return id;
  }
  Future<List> getAllEmployee()async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from employee");
    return data.toList();
  }
  Future<int> deleteEmployee(id) async
  {
    var db = await create_db();
    var status = await db.rawDelete("delete from employee where eid=?",[id]);
    return status;
  }


}