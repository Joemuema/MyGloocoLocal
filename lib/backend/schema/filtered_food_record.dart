import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FilteredFoodRecord extends FirestoreRecord {
  FilteredFoodRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Code" field.
  String? _code;
  String get code => _code ?? '';
  bool hasCode() => _code != null;

  // "Food" field.
  String? _food;
  String get food => _food ?? '';
  bool hasFood() => _food != null;

  // "Energy_KJ" field.
  double? _energyKJ;
  double get energyKJ => _energyKJ ?? 0.0;
  bool hasEnergyKJ() => _energyKJ != null;

  // "Energy_Kcal" field.
  double? _energyKcal;
  double get energyKcal => _energyKcal ?? 0.0;
  bool hasEnergyKcal() => _energyKcal != null;

  // "Protein" field.
  double? _protein;
  double get protein => _protein ?? 0.0;
  bool hasProtein() => _protein != null;

  // "Fat" field.
  double? _fat;
  double get fat => _fat ?? 0.0;
  bool hasFat() => _fat != null;

  // "Carbohydrates" field.
  double? _carbohydrates;
  double get carbohydrates => _carbohydrates ?? 0.0;
  bool hasCarbohydrates() => _carbohydrates != null;

  // "Fibre" field.
  double? _fibre;
  double get fibre => _fibre ?? 0.0;
  bool hasFibre() => _fibre != null;

  // "Category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  void _initializeFields() {
    _code = snapshotData['Code'] as String?;
    _food = snapshotData['Food'] as String?;
    _energyKJ = castToType<double>(snapshotData['Energy_KJ']);
    _energyKcal = castToType<double>(snapshotData['Energy_Kcal']);
    _protein = castToType<double>(snapshotData['Protein']);
    _fat = castToType<double>(snapshotData['Fat']);
    _carbohydrates = castToType<double>(snapshotData['Carbohydrates']);
    _fibre = castToType<double>(snapshotData['Fibre']);
    _category = snapshotData['Category'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('filtered_food');

  static Stream<FilteredFoodRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FilteredFoodRecord.fromSnapshot(s));

  static Future<FilteredFoodRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FilteredFoodRecord.fromSnapshot(s));

  static FilteredFoodRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FilteredFoodRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FilteredFoodRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FilteredFoodRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FilteredFoodRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FilteredFoodRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFilteredFoodRecordData({
  String? code,
  String? food,
  double? energyKJ,
  double? energyKcal,
  double? protein,
  double? fat,
  double? carbohydrates,
  double? fibre,
  String? category,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Code': code,
      'Food': food,
      'Energy_KJ': energyKJ,
      'Energy_Kcal': energyKcal,
      'Protein': protein,
      'Fat': fat,
      'Carbohydrates': carbohydrates,
      'Fibre': fibre,
      'Category': category,
    }.withoutNulls,
  );

  return firestoreData;
}

class FilteredFoodRecordDocumentEquality
    implements Equality<FilteredFoodRecord> {
  const FilteredFoodRecordDocumentEquality();

  @override
  bool equals(FilteredFoodRecord? e1, FilteredFoodRecord? e2) {
    return e1?.code == e2?.code &&
        e1?.food == e2?.food &&
        e1?.energyKJ == e2?.energyKJ &&
        e1?.energyKcal == e2?.energyKcal &&
        e1?.protein == e2?.protein &&
        e1?.fat == e2?.fat &&
        e1?.carbohydrates == e2?.carbohydrates &&
        e1?.fibre == e2?.fibre &&
        e1?.category == e2?.category;
  }

  @override
  int hash(FilteredFoodRecord? e) => const ListEquality().hash([
        e?.code,
        e?.food,
        e?.energyKJ,
        e?.energyKcal,
        e?.protein,
        e?.fat,
        e?.carbohydrates,
        e?.fibre,
        e?.category
      ]);

  @override
  bool isValidKey(Object? o) => o is FilteredFoodRecord;
}
