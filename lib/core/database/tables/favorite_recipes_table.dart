import 'package:drift/drift.dart';
import 'package:mockai/core/database/converters/list_string_converter.dart';

@DataClassName('FavoriteRecipeEntry')
class FavoriteRecipes extends Table {
  IntColumn get id => integer()(); 
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
  TextColumn get ingredients => text().map(const ListStringConverter())();
  TextColumn get instructions => text().map(const ListStringConverter())();
  IntColumn get prepTimeMin => integer()();
  IntColumn get cookTimeMin => integer()();
  IntColumn get servings => integer()();
  TextColumn get difficulty => text()();
  TextColumn get cuisine => text()();
  IntColumn get caloriesPerServing => integer()();
  TextColumn get mealTypes => text().map(const ListStringConverter())();
  RealColumn get rating => real()();
  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
