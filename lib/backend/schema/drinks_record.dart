import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DrinksRecord extends FirestoreRecord {
  DrinksRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Drink" field.
  String? _drink;
  String get drink => _drink ?? '';
  bool hasDrink() => _drink != null;

  // "Time" field.
  String? _time;
  String get time => _time ?? '';
  bool hasTime() => _time != null;

  // "Date" field.
  String? _date;
  String get date => _date ?? '';
  bool hasDate() => _date != null;

  // "Volume" field.
  String? _volume;
  String get volume => _volume ?? '';
  bool hasVolume() => _volume != null;

  // "UserID" field.
  DocumentReference? _userID;
  DocumentReference? get userID => _userID;
  bool hasUserID() => _userID != null;

  void _initializeFields() {
    _drink = snapshotData['Drink'] as String?;
    _time = snapshotData['Time'] as String?;
    _date = snapshotData['Date'] as String?;
    _volume = snapshotData['Volume'] as String?;
    _userID = snapshotData['UserID'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Drinks');

  static Stream<DrinksRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DrinksRecord.fromSnapshot(s));

  static Future<DrinksRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DrinksRecord.fromSnapshot(s));

  static DrinksRecord fromSnapshot(DocumentSnapshot snapshot) => DrinksRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DrinksRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DrinksRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DrinksRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DrinksRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDrinksRecordData({
  String? drink,
  String? time,
  String? date,
  String? volume,
  DocumentReference? userID,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Drink': drink,
      'Time': time,
      'Date': date,
      'Volume': volume,
      'UserID': userID,
    }.withoutNulls,
  );

  return firestoreData;
}

class DrinksRecordDocumentEquality implements Equality<DrinksRecord> {
  const DrinksRecordDocumentEquality();

  @override
  bool equals(DrinksRecord? e1, DrinksRecord? e2) {
    return e1?.drink == e2?.drink &&
        e1?.time == e2?.time &&
        e1?.date == e2?.date &&
        e1?.volume == e2?.volume &&
        e1?.userID == e2?.userID;
  }

  @override
  int hash(DrinksRecord? e) => const ListEquality()
      .hash([e?.drink, e?.time, e?.date, e?.volume, e?.userID]);

  @override
  bool isValidKey(Object? o) => o is DrinksRecord;
}
