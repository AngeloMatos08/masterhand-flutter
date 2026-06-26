import 'package:drift/drift.dart';
import '../local/app_database.dart';

class RpgRepository {
  final AppDatabase _db;

  const RpgRepository(this._db);

  Stream<List<System>> watchAllSystems() =>
      (_db.select(_db.systems)..orderBy([(s) => OrderingTerm.asc(s.title)]))
          .watch();

  Stream<List<System>> watchFavorites() =>
      (_db.select(_db.systems)..where((s) => s.isFavorite.equals(1)))
          .watch();

  Future<void> toggleFavorite(int id, int current) =>
      (_db.update(_db.systems)..where((s) => s.id.equals(id)))
          .write(SystemsCompanion(isFavorite: Value(current == 1 ? 0 : 1)));

  Stream<List<Category>> watchAllCategories() =>
      _db.select(_db.categories).watch();
}
