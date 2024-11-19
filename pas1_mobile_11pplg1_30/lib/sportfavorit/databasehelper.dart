import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../sport/sport_model.dart';
import 'sportfavorit_model.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        idTeam INTEGER PRIMARY KEY,
        strTeam TEXT,
        strTeamBadge TEXT,
        strStadium TEXT,
        strDescriptionEN TEXT,
        imageUrl TEXT
      )
    ''');
  }

  Future<int> addFavorite(FavoriteTeam team) async {
    final db = await instance.database;
    return await db.insert('favorites', {
      'idTeam': team.idTeam,
      'strTeam': team.strTeam,
      'strTeamBadge': team.strTeamBadge,
      'strStadium': team.strStadium,
      'strDescriptionEN': team.strDescriptionEN,
      'imageUrl': team.imageUrl,
    });
  }

  Future<bool> isFavorite(int idTeam) async {
    final db = await instance.database;
    final result = await db.query(
      'favorites',
      where: 'idTeam = ?',
      whereArgs: [idTeam],
    );
    return result.isNotEmpty;
  }

  Future<int> removeFavorite(int idTeam) async {
    final db = await instance.database;
    return await db.delete(
      'favorites',
      where: 'idTeam = ?',
      whereArgs: [idTeam],
    );
  }

  Future<List<FavoriteTeam>> getAllFavorites() async {
    final db = await instance.database;
    final result = await db.query('favorites');
    return result.map((json) => FavoriteTeam.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
} 