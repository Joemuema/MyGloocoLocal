import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MealsRecord extends FirestoreRecord {
  MealsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "meals" field.
  List<String>? _meals;
  List<String> get meals => _meals ?? const [];
  bool hasMeals() => _meals != null;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  bool hasDate() => _date != null;

  // "UserID" field.
  DocumentReference? _userID;
  DocumentReference? get userID => _userID;
  bool hasUserID() => _userID != null;

  // "totalMealKcals" field.
  double? _totalMealKcals;
  double get totalMealKcals => _totalMealKcals ?? 0.0;
  bool hasTotalMealKcals() => _totalMealKcals != null;

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  void _initializeFields() {
    _type = snapshotData['type'] as String?;
    _meals = getDataList(snapshotData['meals']);
    _date = snapshotData['date'] as String?;
    _userID = snapshotData['UserID'] as DocumentReference?;
    _totalMealKcals = castToType<double>(snapshotData['totalMealKcals']);
    _dateTime = snapshotData['dateTime'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Meals');

  static Stream<MealsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MealsRecord.fromSnapshot(s));

  static Future<MealsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MealsRecord.fromSnapshot(s));

  static MealsRecord fromSnapshot(DocumentSnapshot snapshot) => MealsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MealsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MealsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MealsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MealsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMealsRecordData({
  String? type,
  String? date,
  DocumentReference? userID,
  double? totalMealKcals,
  DateTime? dateTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'type': type,
      'date': date,
      'UserID': userID,
      'totalMealKcals': totalMealKcals,
      'dateTime': dateTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class MealsRecordDocumentEquality implements Equality<MealsRecord> {
  const MealsRecordDocumentEquality();

  @override
  bool equals(MealsRecord? e1, MealsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.type == e2?.type &&
        listEquality.equals(e1?.meals, e2?.meals) &&
        e1?.date == e2?.date &&
        e1?.userID == e2?.userID &&
        e1?.totalMealKcals == e2?.totalMealKcals &&
        e1?.dateTime == e2?.dateTime;
  }

  @override
  int hash(MealsRecord? e) => const ListEquality().hash(
      [e?.type, e?.meals, e?.date, e?.userID, e?.totalMealKcals, e?.dateTime]);

  @override
  bool isValidKey(Object? o) => o is MealsRecord;
}
