import 'package:drift/drift.dart';

class Categories extends Table {
  @override
  String get tableName => 'category';

  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();

  @override
  Set<Column> get primaryKey => {id};
}

class Systems extends Table {
  @override
  String get tableName => 'system';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  BlobColumn get cover => blob().nullable()();
  TextColumn get categories => text()();
  TextColumn get categoryShow1 => text()();
  TextColumn get categoryShow2 => text()();
  TextColumn get storeLink => text()();
  TextColumn get storeName => text()();
  TextColumn get description => text()();
  RealColumn get price => real().nullable()();
  BoolColumn get isFavorite =>
      boolean().withDefault(const Constant(false))();
}
