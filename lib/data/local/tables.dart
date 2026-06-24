import 'package:drift/drift.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
}

class Systems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text()();
  TextColumn get officialLink => text().nullable()();
  BoolColumn get isFavorite =>
      boolean().withDefault(const Constant(false))();
  IntColumn get categoryId =>
      integer().references(Categories, #id)();
}
