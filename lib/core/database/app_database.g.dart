// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
mixin _$FavoritesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FavoriteRecipesTable get favoriteRecipes => attachedDatabase.favoriteRecipes;
  FavoritesDaoManager get managers => FavoritesDaoManager(this);
}

class FavoritesDaoManager {
  final _$FavoritesDaoMixin _db;
  FavoritesDaoManager(this._db);
  $$FavoriteRecipesTableTableManager get favoriteRecipes =>
      $$FavoriteRecipesTableTableManager(
        _db.attachedDatabase,
        _db.favoriteRecipes,
      );
}

class $FavoriteRecipesTable extends FavoriteRecipes
    with TableInfo<$FavoriteRecipesTable, FavoriteRecipeEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteRecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  ingredients = GeneratedColumn<String>(
    'ingredients',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<List<String>>($FavoriteRecipesTable.$converteringredients);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<List<String>>($FavoriteRecipesTable.$converterinstructions);
  static const VerificationMeta _prepTimeMinMeta = const VerificationMeta(
    'prepTimeMin',
  );
  @override
  late final GeneratedColumn<int> prepTimeMin = GeneratedColumn<int>(
    'prep_time_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cookTimeMinMeta = const VerificationMeta(
    'cookTimeMin',
  );
  @override
  late final GeneratedColumn<int> cookTimeMin = GeneratedColumn<int>(
    'cook_time_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<int> servings = GeneratedColumn<int>(
    'servings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cuisineMeta = const VerificationMeta(
    'cuisine',
  );
  @override
  late final GeneratedColumn<String> cuisine = GeneratedColumn<String>(
    'cuisine',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesPerServingMeta =
      const VerificationMeta('caloriesPerServing');
  @override
  late final GeneratedColumn<int> caloriesPerServing = GeneratedColumn<int>(
    'calories_per_serving',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> mealTypes =
      GeneratedColumn<String>(
        'meal_types',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($FavoriteRecipesTable.$convertermealTypes);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    imageUrl,
    ingredients,
    instructions,
    prepTimeMin,
    cookTimeMin,
    servings,
    difficulty,
    cuisine,
    caloriesPerServing,
    mealTypes,
    rating,
    savedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteRecipeEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('prep_time_min')) {
      context.handle(
        _prepTimeMinMeta,
        prepTimeMin.isAcceptableOrUnknown(
          data['prep_time_min']!,
          _prepTimeMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prepTimeMinMeta);
    }
    if (data.containsKey('cook_time_min')) {
      context.handle(
        _cookTimeMinMeta,
        cookTimeMin.isAcceptableOrUnknown(
          data['cook_time_min']!,
          _cookTimeMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cookTimeMinMeta);
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    } else if (isInserting) {
      context.missing(_servingsMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('cuisine')) {
      context.handle(
        _cuisineMeta,
        cuisine.isAcceptableOrUnknown(data['cuisine']!, _cuisineMeta),
      );
    } else if (isInserting) {
      context.missing(_cuisineMeta);
    }
    if (data.containsKey('calories_per_serving')) {
      context.handle(
        _caloriesPerServingMeta,
        caloriesPerServing.isAcceptableOrUnknown(
          data['calories_per_serving']!,
          _caloriesPerServingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesPerServingMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteRecipeEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteRecipeEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      ingredients: $FavoriteRecipesTable.$converteringredients.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}ingredients'],
        )!,
      ),
      instructions: $FavoriteRecipesTable.$converterinstructions.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}instructions'],
        )!,
      ),
      prepTimeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prep_time_min'],
      )!,
      cookTimeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cook_time_min'],
      )!,
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servings'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      cuisine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cuisine'],
      )!,
      caloriesPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories_per_serving'],
      )!,
      mealTypes: $FavoriteRecipesTable.$convertermealTypes.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}meal_types'],
        )!,
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      )!,
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $FavoriteRecipesTable createAlias(String alias) {
    return $FavoriteRecipesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converteringredients =
      const ListStringConverter();
  static TypeConverter<List<String>, String> $converterinstructions =
      const ListStringConverter();
  static TypeConverter<List<String>, String> $convertermealTypes =
      const ListStringConverter();
}

class FavoriteRecipeEntry extends DataClass
    implements Insertable<FavoriteRecipeEntry> {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final int prepTimeMin;
  final int cookTimeMin;
  final int servings;
  final String difficulty;
  final String cuisine;
  final int caloriesPerServing;
  final List<String> mealTypes;
  final double rating;
  final DateTime savedAt;
  const FavoriteRecipeEntry({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMin,
    required this.cookTimeMin,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.mealTypes,
    required this.rating,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image_url'] = Variable<String>(imageUrl);
    {
      map['ingredients'] = Variable<String>(
        $FavoriteRecipesTable.$converteringredients.toSql(ingredients),
      );
    }
    {
      map['instructions'] = Variable<String>(
        $FavoriteRecipesTable.$converterinstructions.toSql(instructions),
      );
    }
    map['prep_time_min'] = Variable<int>(prepTimeMin);
    map['cook_time_min'] = Variable<int>(cookTimeMin);
    map['servings'] = Variable<int>(servings);
    map['difficulty'] = Variable<String>(difficulty);
    map['cuisine'] = Variable<String>(cuisine);
    map['calories_per_serving'] = Variable<int>(caloriesPerServing);
    {
      map['meal_types'] = Variable<String>(
        $FavoriteRecipesTable.$convertermealTypes.toSql(mealTypes),
      );
    }
    map['rating'] = Variable<double>(rating);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  FavoriteRecipesCompanion toCompanion(bool nullToAbsent) {
    return FavoriteRecipesCompanion(
      id: Value(id),
      name: Value(name),
      imageUrl: Value(imageUrl),
      ingredients: Value(ingredients),
      instructions: Value(instructions),
      prepTimeMin: Value(prepTimeMin),
      cookTimeMin: Value(cookTimeMin),
      servings: Value(servings),
      difficulty: Value(difficulty),
      cuisine: Value(cuisine),
      caloriesPerServing: Value(caloriesPerServing),
      mealTypes: Value(mealTypes),
      rating: Value(rating),
      savedAt: Value(savedAt),
    );
  }

  factory FavoriteRecipeEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteRecipeEntry(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      ingredients: serializer.fromJson<List<String>>(json['ingredients']),
      instructions: serializer.fromJson<List<String>>(json['instructions']),
      prepTimeMin: serializer.fromJson<int>(json['prepTimeMin']),
      cookTimeMin: serializer.fromJson<int>(json['cookTimeMin']),
      servings: serializer.fromJson<int>(json['servings']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      cuisine: serializer.fromJson<String>(json['cuisine']),
      caloriesPerServing: serializer.fromJson<int>(json['caloriesPerServing']),
      mealTypes: serializer.fromJson<List<String>>(json['mealTypes']),
      rating: serializer.fromJson<double>(json['rating']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'ingredients': serializer.toJson<List<String>>(ingredients),
      'instructions': serializer.toJson<List<String>>(instructions),
      'prepTimeMin': serializer.toJson<int>(prepTimeMin),
      'cookTimeMin': serializer.toJson<int>(cookTimeMin),
      'servings': serializer.toJson<int>(servings),
      'difficulty': serializer.toJson<String>(difficulty),
      'cuisine': serializer.toJson<String>(cuisine),
      'caloriesPerServing': serializer.toJson<int>(caloriesPerServing),
      'mealTypes': serializer.toJson<List<String>>(mealTypes),
      'rating': serializer.toJson<double>(rating),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  FavoriteRecipeEntry copyWith({
    int? id,
    String? name,
    String? imageUrl,
    List<String>? ingredients,
    List<String>? instructions,
    int? prepTimeMin,
    int? cookTimeMin,
    int? servings,
    String? difficulty,
    String? cuisine,
    int? caloriesPerServing,
    List<String>? mealTypes,
    double? rating,
    DateTime? savedAt,
  }) => FavoriteRecipeEntry(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
    ingredients: ingredients ?? this.ingredients,
    instructions: instructions ?? this.instructions,
    prepTimeMin: prepTimeMin ?? this.prepTimeMin,
    cookTimeMin: cookTimeMin ?? this.cookTimeMin,
    servings: servings ?? this.servings,
    difficulty: difficulty ?? this.difficulty,
    cuisine: cuisine ?? this.cuisine,
    caloriesPerServing: caloriesPerServing ?? this.caloriesPerServing,
    mealTypes: mealTypes ?? this.mealTypes,
    rating: rating ?? this.rating,
    savedAt: savedAt ?? this.savedAt,
  );
  FavoriteRecipeEntry copyWithCompanion(FavoriteRecipesCompanion data) {
    return FavoriteRecipeEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      ingredients: data.ingredients.present
          ? data.ingredients.value
          : this.ingredients,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      prepTimeMin: data.prepTimeMin.present
          ? data.prepTimeMin.value
          : this.prepTimeMin,
      cookTimeMin: data.cookTimeMin.present
          ? data.cookTimeMin.value
          : this.cookTimeMin,
      servings: data.servings.present ? data.servings.value : this.servings,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      cuisine: data.cuisine.present ? data.cuisine.value : this.cuisine,
      caloriesPerServing: data.caloriesPerServing.present
          ? data.caloriesPerServing.value
          : this.caloriesPerServing,
      mealTypes: data.mealTypes.present ? data.mealTypes.value : this.mealTypes,
      rating: data.rating.present ? data.rating.value : this.rating,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRecipeEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('ingredients: $ingredients, ')
          ..write('instructions: $instructions, ')
          ..write('prepTimeMin: $prepTimeMin, ')
          ..write('cookTimeMin: $cookTimeMin, ')
          ..write('servings: $servings, ')
          ..write('difficulty: $difficulty, ')
          ..write('cuisine: $cuisine, ')
          ..write('caloriesPerServing: $caloriesPerServing, ')
          ..write('mealTypes: $mealTypes, ')
          ..write('rating: $rating, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    imageUrl,
    ingredients,
    instructions,
    prepTimeMin,
    cookTimeMin,
    servings,
    difficulty,
    cuisine,
    caloriesPerServing,
    mealTypes,
    rating,
    savedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteRecipeEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl &&
          other.ingredients == this.ingredients &&
          other.instructions == this.instructions &&
          other.prepTimeMin == this.prepTimeMin &&
          other.cookTimeMin == this.cookTimeMin &&
          other.servings == this.servings &&
          other.difficulty == this.difficulty &&
          other.cuisine == this.cuisine &&
          other.caloriesPerServing == this.caloriesPerServing &&
          other.mealTypes == this.mealTypes &&
          other.rating == this.rating &&
          other.savedAt == this.savedAt);
}

class FavoriteRecipesCompanion extends UpdateCompanion<FavoriteRecipeEntry> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<List<String>> ingredients;
  final Value<List<String>> instructions;
  final Value<int> prepTimeMin;
  final Value<int> cookTimeMin;
  final Value<int> servings;
  final Value<String> difficulty;
  final Value<String> cuisine;
  final Value<int> caloriesPerServing;
  final Value<List<String>> mealTypes;
  final Value<double> rating;
  final Value<DateTime> savedAt;
  const FavoriteRecipesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.instructions = const Value.absent(),
    this.prepTimeMin = const Value.absent(),
    this.cookTimeMin = const Value.absent(),
    this.servings = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.cuisine = const Value.absent(),
    this.caloriesPerServing = const Value.absent(),
    this.mealTypes = const Value.absent(),
    this.rating = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  FavoriteRecipesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String imageUrl,
    required List<String> ingredients,
    required List<String> instructions,
    required int prepTimeMin,
    required int cookTimeMin,
    required int servings,
    required String difficulty,
    required String cuisine,
    required int caloriesPerServing,
    required List<String> mealTypes,
    required double rating,
    this.savedAt = const Value.absent(),
  }) : name = Value(name),
       imageUrl = Value(imageUrl),
       ingredients = Value(ingredients),
       instructions = Value(instructions),
       prepTimeMin = Value(prepTimeMin),
       cookTimeMin = Value(cookTimeMin),
       servings = Value(servings),
       difficulty = Value(difficulty),
       cuisine = Value(cuisine),
       caloriesPerServing = Value(caloriesPerServing),
       mealTypes = Value(mealTypes),
       rating = Value(rating);
  static Insertable<FavoriteRecipeEntry> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? imageUrl,
    Expression<String>? ingredients,
    Expression<String>? instructions,
    Expression<int>? prepTimeMin,
    Expression<int>? cookTimeMin,
    Expression<int>? servings,
    Expression<String>? difficulty,
    Expression<String>? cuisine,
    Expression<int>? caloriesPerServing,
    Expression<String>? mealTypes,
    Expression<double>? rating,
    Expression<DateTime>? savedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
      if (ingredients != null) 'ingredients': ingredients,
      if (instructions != null) 'instructions': instructions,
      if (prepTimeMin != null) 'prep_time_min': prepTimeMin,
      if (cookTimeMin != null) 'cook_time_min': cookTimeMin,
      if (servings != null) 'servings': servings,
      if (difficulty != null) 'difficulty': difficulty,
      if (cuisine != null) 'cuisine': cuisine,
      if (caloriesPerServing != null)
        'calories_per_serving': caloriesPerServing,
      if (mealTypes != null) 'meal_types': mealTypes,
      if (rating != null) 'rating': rating,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  FavoriteRecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? imageUrl,
    Value<List<String>>? ingredients,
    Value<List<String>>? instructions,
    Value<int>? prepTimeMin,
    Value<int>? cookTimeMin,
    Value<int>? servings,
    Value<String>? difficulty,
    Value<String>? cuisine,
    Value<int>? caloriesPerServing,
    Value<List<String>>? mealTypes,
    Value<double>? rating,
    Value<DateTime>? savedAt,
  }) {
    return FavoriteRecipesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      prepTimeMin: prepTimeMin ?? this.prepTimeMin,
      cookTimeMin: cookTimeMin ?? this.cookTimeMin,
      servings: servings ?? this.servings,
      difficulty: difficulty ?? this.difficulty,
      cuisine: cuisine ?? this.cuisine,
      caloriesPerServing: caloriesPerServing ?? this.caloriesPerServing,
      mealTypes: mealTypes ?? this.mealTypes,
      rating: rating ?? this.rating,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (ingredients.present) {
      map['ingredients'] = Variable<String>(
        $FavoriteRecipesTable.$converteringredients.toSql(ingredients.value),
      );
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(
        $FavoriteRecipesTable.$converterinstructions.toSql(instructions.value),
      );
    }
    if (prepTimeMin.present) {
      map['prep_time_min'] = Variable<int>(prepTimeMin.value);
    }
    if (cookTimeMin.present) {
      map['cook_time_min'] = Variable<int>(cookTimeMin.value);
    }
    if (servings.present) {
      map['servings'] = Variable<int>(servings.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (cuisine.present) {
      map['cuisine'] = Variable<String>(cuisine.value);
    }
    if (caloriesPerServing.present) {
      map['calories_per_serving'] = Variable<int>(caloriesPerServing.value);
    }
    if (mealTypes.present) {
      map['meal_types'] = Variable<String>(
        $FavoriteRecipesTable.$convertermealTypes.toSql(mealTypes.value),
      );
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRecipesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('ingredients: $ingredients, ')
          ..write('instructions: $instructions, ')
          ..write('prepTimeMin: $prepTimeMin, ')
          ..write('cookTimeMin: $cookTimeMin, ')
          ..write('servings: $servings, ')
          ..write('difficulty: $difficulty, ')
          ..write('cuisine: $cuisine, ')
          ..write('caloriesPerServing: $caloriesPerServing, ')
          ..write('mealTypes: $mealTypes, ')
          ..write('rating: $rating, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteRecipesTable favoriteRecipes = $FavoriteRecipesTable(
    this,
  );
  late final FavoritesDao favoritesDao = FavoritesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoriteRecipes];
}

typedef $$FavoriteRecipesTableCreateCompanionBuilder =
    FavoriteRecipesCompanion Function({
      Value<int> id,
      required String name,
      required String imageUrl,
      required List<String> ingredients,
      required List<String> instructions,
      required int prepTimeMin,
      required int cookTimeMin,
      required int servings,
      required String difficulty,
      required String cuisine,
      required int caloriesPerServing,
      required List<String> mealTypes,
      required double rating,
      Value<DateTime> savedAt,
    });
typedef $$FavoriteRecipesTableUpdateCompanionBuilder =
    FavoriteRecipesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> imageUrl,
      Value<List<String>> ingredients,
      Value<List<String>> instructions,
      Value<int> prepTimeMin,
      Value<int> cookTimeMin,
      Value<int> servings,
      Value<String> difficulty,
      Value<String> cuisine,
      Value<int> caloriesPerServing,
      Value<List<String>> mealTypes,
      Value<double> rating,
      Value<DateTime> savedAt,
    });

class $$FavoriteRecipesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteRecipesTable> {
  $$FavoriteRecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get prepTimeMin => $composableBuilder(
    column: $table.prepTimeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cookTimeMin => $composableBuilder(
    column: $table.cookTimeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cuisine => $composableBuilder(
    column: $table.cuisine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get mealTypes => $composableBuilder(
    column: $table.mealTypes,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteRecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteRecipesTable> {
  $$FavoriteRecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prepTimeMin => $composableBuilder(
    column: $table.prepTimeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cookTimeMin => $composableBuilder(
    column: $table.cookTimeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cuisine => $composableBuilder(
    column: $table.cuisine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealTypes => $composableBuilder(
    column: $table.mealTypes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteRecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteRecipesTable> {
  $$FavoriteRecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get ingredients =>
      $composableBuilder(
        column: $table.ingredients,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<String>, String> get instructions =>
      $composableBuilder(
        column: $table.instructions,
        builder: (column) => column,
      );

  GeneratedColumn<int> get prepTimeMin => $composableBuilder(
    column: $table.prepTimeMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cookTimeMin => $composableBuilder(
    column: $table.cookTimeMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cuisine =>
      $composableBuilder(column: $table.cuisine, builder: (column) => column);

  GeneratedColumn<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>, String> get mealTypes =>
      $composableBuilder(column: $table.mealTypes, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$FavoriteRecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteRecipesTable,
          FavoriteRecipeEntry,
          $$FavoriteRecipesTableFilterComposer,
          $$FavoriteRecipesTableOrderingComposer,
          $$FavoriteRecipesTableAnnotationComposer,
          $$FavoriteRecipesTableCreateCompanionBuilder,
          $$FavoriteRecipesTableUpdateCompanionBuilder,
          (
            FavoriteRecipeEntry,
            BaseReferences<
              _$AppDatabase,
              $FavoriteRecipesTable,
              FavoriteRecipeEntry
            >,
          ),
          FavoriteRecipeEntry,
          PrefetchHooks Function()
        > {
  $$FavoriteRecipesTableTableManager(
    _$AppDatabase db,
    $FavoriteRecipesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteRecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteRecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteRecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<List<String>> ingredients = const Value.absent(),
                Value<List<String>> instructions = const Value.absent(),
                Value<int> prepTimeMin = const Value.absent(),
                Value<int> cookTimeMin = const Value.absent(),
                Value<int> servings = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> cuisine = const Value.absent(),
                Value<int> caloriesPerServing = const Value.absent(),
                Value<List<String>> mealTypes = const Value.absent(),
                Value<double> rating = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
              }) => FavoriteRecipesCompanion(
                id: id,
                name: name,
                imageUrl: imageUrl,
                ingredients: ingredients,
                instructions: instructions,
                prepTimeMin: prepTimeMin,
                cookTimeMin: cookTimeMin,
                servings: servings,
                difficulty: difficulty,
                cuisine: cuisine,
                caloriesPerServing: caloriesPerServing,
                mealTypes: mealTypes,
                rating: rating,
                savedAt: savedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String imageUrl,
                required List<String> ingredients,
                required List<String> instructions,
                required int prepTimeMin,
                required int cookTimeMin,
                required int servings,
                required String difficulty,
                required String cuisine,
                required int caloriesPerServing,
                required List<String> mealTypes,
                required double rating,
                Value<DateTime> savedAt = const Value.absent(),
              }) => FavoriteRecipesCompanion.insert(
                id: id,
                name: name,
                imageUrl: imageUrl,
                ingredients: ingredients,
                instructions: instructions,
                prepTimeMin: prepTimeMin,
                cookTimeMin: cookTimeMin,
                servings: servings,
                difficulty: difficulty,
                cuisine: cuisine,
                caloriesPerServing: caloriesPerServing,
                mealTypes: mealTypes,
                rating: rating,
                savedAt: savedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteRecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteRecipesTable,
      FavoriteRecipeEntry,
      $$FavoriteRecipesTableFilterComposer,
      $$FavoriteRecipesTableOrderingComposer,
      $$FavoriteRecipesTableAnnotationComposer,
      $$FavoriteRecipesTableCreateCompanionBuilder,
      $$FavoriteRecipesTableUpdateCompanionBuilder,
      (
        FavoriteRecipeEntry,
        BaseReferences<
          _$AppDatabase,
          $FavoriteRecipesTable,
          FavoriteRecipeEntry
        >,
      ),
      FavoriteRecipeEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteRecipesTableTableManager get favoriteRecipes =>
      $$FavoriteRecipesTableTableManager(_db, _db.favoriteRecipes);
}
