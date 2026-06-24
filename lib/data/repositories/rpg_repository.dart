import 'package:drift/drift.dart';
import '../local/app_database.dart';

class RpgRepository {
  final AppDatabase _db;

  const RpgRepository(this._db);

  Stream<List<System>> watchAllSystems() => _db.select(_db.systems).watch();

  Stream<List<System>> watchFavorites() =>
      (_db.select(_db.systems)..where((s) => s.isFavorite.equals(true)))
          .watch();

  Future<void> toggleFavorite(int id, bool current) =>
      (_db.update(_db.systems)..where((s) => s.id.equals(id)))
          .write(SystemsCompanion(isFavorite: Value(!current)));

  Stream<List<Category>> watchAllCategories() =>
      _db.select(_db.categories).watch();
}
