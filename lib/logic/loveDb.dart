import 'package:Raylex/logic/models/songInfo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LoveDb{
  get tableLove => "loved";

  Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'loved_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS $tableLove(id INTEGER PRIMARY KEY, artist TEXT, title TEXT, album TEXT, albumId INTERGER, duration INTEGER, uri TEXT, albumArt TEXT, trackId INTEGER)',
        );
      },
      // Version provides path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  
  Future<void> insertLove(SongInfo songInfo) async {
    // Get a reference to the database.
    final Database database = await db();

    // Insert the Product into the correct table.
    // Specify `conflictAlgorithm`.
    // In this case, if the same product is inserted
    // multiple times, it replaces the previous data.
    await database.insert(
      tableLove,
      songInfo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteLove(int id) async {
    // Get a reference to the database.
    final database = await db();

    // Remove the Product from the database.
    await database.delete(
      tableLove,
      // Use a `where` clause to delete a specific product.
      where: "id = ?",
      // Pass the Products's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<List<SongInfo>> allLove() async {
    // Get a reference to the database.
    final Database database = await db();

    // Query the table for all The Products.
    final List<Map<String, dynamic>> maps = await database.query(tableLove);

    // Convert the List<Map<String, dynamic> into a List<Product>.
    return List.generate(
      maps.length,
      (i) {
        return SongInfo(
          maps[i]['id'],
          maps[i]['artist'],
          maps[i]['title'],
          maps[i]['album'],
          maps[i]['albumId'],
          maps[i]['duration'],
          maps[i]['uri'],
          maps[i]['albumArt'],
          maps[i]['trackId']
        );
      },
    );
  }
}