import 'package:music_player/models/music_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Musics.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Musics(id INTEGER PRIMARY KEY, title TEXT NOT NULL, type TEXT NOT NULL, isFavorite INTEGER NOT NULL);"),
        version: _version);
  }

  static Future<int> addMusicToDb(Music music) async {
    final db = await _getDB();
    return await db.insert("Musics", music.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateFavMusic(Music music) async {
    final db = await _getDB();
    return await db.update("Musics", music.toJson(),
        where: 'id = ?',
        whereArgs: [music.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteFavMusic(Music music) async {
    final db = await _getDB();
    return await db.delete(
      "Musics",
      where: 'id = ?',
      whereArgs: [music.id],
    );
  }

  static Future<List<Music>> getAllMusics() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Musics");

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (index) => Music.fromJson(maps[index]));
  }
}
