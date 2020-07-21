import 'package:Raylex/logic/models/modelLyrics.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LyricsDb{
  get tableLyrics => "lyrics";

  Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'lyrics_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS $tableLyrics(id INTEGER PRIMARY KEY, lyrics TEXT, songName TEXT, artistName TEXT)',
        );
      },
      // Version provides path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertProduct(ModelLyrics lyrics) async {
    // Get a reference to the database.
    final Database database = await db();

    // Insert the Product into the correct table.
    // Specify `conflictAlgorithm`.
    // In this case, if the same product is inserted
    // multiple times, it replaces the previous data.
    await database.insert(
      tableLyrics,
      lyrics.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteProduct(int id) async {
    // Get a reference to the database.
    final database = await db();

    // Remove the Product from the database.
    await database.delete(
      tableLyrics,
      // Use a `where` clause to delete a specific product.
      where: "id = ?",
      // Pass the Products's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<List<ModelLyrics>> allLyrics() async {
    // Get a reference to the database.
    final Database database = await db();

    // Query the table for all The Products.
    final List<Map<String, dynamic>> maps = await database.query(tableLyrics);

    // Convert the List<Map<String, dynamic> into a List<Product>.
    return List.generate(
      maps.length,
      (i) {
        return ModelLyrics(
            id: maps[i]['id'],
            lyrics: maps[i]['lyrics'],
            songName: maps[i]['songName'],
            artistName: maps[i]['artistName']
          );
      },
    );
  }

  Future<String> specificLyrics(String songName, String artistName) async {
    // Get a reference to the database.
    final Database database = await db();

    // Query the table for all The Products.
    final List<Map<String, dynamic>> maps = await database.query(
      tableLyrics,
      where: "songName=?",
      whereArgs: [songName]
    );

    if(maps.isNotEmpty)
      return maps[0]['lyrics'];
    else
      return "No result found";
  }

}