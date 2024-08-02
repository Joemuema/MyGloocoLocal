import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecipesRecord extends FirestoreRecord {
  RecipesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "Prep_Time" field.
  int? _prepTime;
  int get prepTime => _prepTime ?? 0;
  bool hasPrepTime() => _prepTime != null;

  // "Cooking_Time" field.
  int? _cookingTime;
  int get cookingTime => _cookingTime ?? 0;
  bool hasCookingTime() => _cookingTime != null;

  // "Servings" field.
  int? _servings;
  int get servings => _servings ?? 0;
  bool hasServings() => _servings != null;

  // "Energy_kJ" field.
  int? _energyKJ;
  int get energyKJ => _energyKJ ?? 0;
  bool hasEnergyKJ() => _energyKJ != null;

  // "Energy_kcal" field.
  int? _energyKcal;
  int get energyKcal => _energyKcal ?? 0;
  bool hasEnergyKcal() => _energyKcal != null;

  // "Protein" field.
  double? _protein;
  double get protein => _protein ?? 0.0;
  bool hasProtein() => _protein != null;

  // "Carbohydrate" field.
  double? _carbohydrate;
  double get carbohydrate => _carbohydrate ?? 0.0;
  bool hasCarbohydrate() => _carbohydrate != null;

  // "Fibre" field.
  double? _fibre;
  double get fibre => _fibre ?? 0.0;
  bool hasFibre() => _fibre != null;

  // "Ingredients" field.
  List<String>? _ingredients;
  List<String> get ingredients => _ingredients ?? const [];
  bool hasIngredients() => _ingredients != null;

  // "Instructions" field.
  List<String>? _instructions;
  List<String> get instructions => _instructions ?? const [];
  bool hasInstructions() => _instructions != null;

  // "Picture" field.
  String? _picture;
  String get picture => _picture ?? '';
  bool hasPicture() => _picture != null;

  // "Fat" field.
  double? _fat;
  double get fat => _fat ?? 0.0;
  bool hasFat() => _fat != null;

  // "Code" field.
  int? _code;
  int get code => _code ?? 0;
  bool hasCode() => _code != null;

  void _initializeFields() {
    _title = snapshotData['Title'] as String?;
    _prepTime = castToType<int>(snapshotData['Prep_Time']);
    _cookingTime = castToType<int>(snapshotData['Cooking_Time']);
    _servings = castToType<int>(snapshotData['Servings']);
    _energyKJ = castToType<int>(snapshotData['Energy_kJ']);
    _energyKcal = castToType<int>(snapshotData['Energy_kcal']);
    _protein = castToType<double>(snapshotData['Protein']);
    _carbohydrate = castToType<double>(snapshotData['Carbohydrate']);
    _fibre = castToType<double>(snapshotData['Fibre']);
    _ingredients = getDataList(snapshotData['Ingredients']);
    _instructions = getDataList(snapshotData['Instructions']);
    _picture = snapshotData['Picture'] as String?;
    _fat = castToType<double>(snapshotData['Fat']);
    _code = castToType<int>(snapshotData['Code']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Recipes');

  static Stream<RecipesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RecipesRecord.fromSnapshot(s));

  static Future<RecipesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RecipesRecord.fromSnapshot(s));

  static RecipesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RecipesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RecipesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RecipesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RecipesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RecipesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRecipesRecordData({
  String? title,
  int? prepTime,
  int? cookingTime,
  int? servings,
  int? energyKJ,
  int? energyKcal,
  double? protein,
  double? carbohydrate,
  double? fibre,
  String? picture,
  double? fat,
  int? code,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Title': title,
      'Prep_Time': prepTime,
      'Cooking_Time': cookingTime,
      'Servings': servings,
      'Energy_kJ': energyKJ,
      'Energy_kcal': energyKcal,
      'Protein': protein,
      'Carbohydrate': carbohydrate,
      'Fibre': fibre,
      'Picture': picture,
      'Fat': fat,
      'Code': code,
    }.withoutNulls,
  );

  return firestoreData;
}

class RecipesRecordDocumentEquality implements Equality<RecipesRecord> {
  const RecipesRecordDocumentEquality();

  @override
  bool equals(RecipesRecord? e1, RecipesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.prepTime == e2?.prepTime &&
        e1?.cookingTime == e2?.cookingTime &&
        e1?.servings == e2?.servings &&
        e1?.energyKJ == e2?.energyKJ &&
        e1?.energyKcal == e2?.energyKcal &&
        e1?.protein == e2?.protein &&
        e1?.carbohydrate == e2?.carbohydrate &&
        e1?.fibre == e2?.fibre &&
        listEquality.equals(e1?.ingredients, e2?.ingredients) &&
        listEquality.equals(e1?.instructions, e2?.instructions) &&
        e1?.picture == e2?.picture &&
        e1?.fat == e2?.fat &&
        e1?.code == e2?.code;
  }

  @override
  int hash(RecipesRecord? e) => const ListEquality().hash([
        e?.title,
        e?.prepTime,
        e?.cookingTime,
        e?.servings,
        e?.energyKJ,
        e?.energyKcal,
        e?.protein,
        e?.carbohydrate,
        e?.fibre,
        e?.ingredients,
        e?.instructions,
        e?.picture,
        e?.fat,
        e?.code
      ]);

  @override
  bool isValidKey(Object? o) => o is RecipesRecord;
}
