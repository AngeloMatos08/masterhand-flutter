import 'package:drift/drift.dart';

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();

  @override
  Set<Column> get primaryKey => {id};
}

class Systems extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text()();
  TextColumn get coverUrl => text().nullable()(); // URL da capa
  TextColumn get storeLink => text()();
  TextColumn get storeName => text()();
  RealColumn get price => real().nullable()();
  BoolColumn get isFavorite =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// Tabela de junção para relacionamento many-to-many entre Systems e Categories
class SystemCategories extends Table {
  IntColumn get systemId => integer().references(Systems, #id)();
  TextColumn get categoryId => text().references(Categories, #id)();

  @override
  Set<Column> get primaryKey => {systemId, categoryId};
}
