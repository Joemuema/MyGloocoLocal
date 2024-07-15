import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BGreadingsRecord extends FirestoreRecord {
  BGreadingsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Date" field.
  String? _date;
  String get date => _date ?? '';
  bool hasDate() => _date != null;

  // "Hour" field.
  int? _hour;
  int get hour => _hour ?? 0;
  bool hasHour() => _hour != null;

  // "Minute" field.
  int? _minute;
  int get minute => _minute ?? 0;
  bool hasMinute() => _minute != null;

  // "CGMreading" field.
  double? _cGMreading;
  double get cGMreading => _cGMreading ?? 0.0;
  bool hasCGMreading() => _cGMreading != null;

  // "Period" field.
  String? _period;
  String get period => _period ?? '';
  bool hasPeriod() => _period != null;

  // "Unit" field.
  String? _unit;
  String get unit => _unit ?? '';
  bool hasUnit() => _unit != null;

  // "DecimalTime" field.
  double? _decimalTime;
  double get decimalTime => _decimalTime ?? 0.0;
  bool hasDecimalTime() => _decimalTime != null;

  // "Time" field.
  String? _time;
  String get time => _time ?? '';
  bool hasTime() => _time != null;

  void _initializeFields() {
    _date = snapshotData['Date'] as String?;
    _hour = castToType<int>(snapshotData['Hour']);
    _minute = castToType<int>(snapshotData['Minute']);
    _cGMreading = castToType<double>(snapshotData['CGMreading']);
    _period = snapshotData['Period'] as String?;
    _unit = snapshotData['Unit'] as String?;
    _decimalTime = castToType<double>(snapshotData['DecimalTime']);
    _time = snapshotData['Time'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('BGreadings');

  static Stream<BGreadingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BGreadingsRecord.fromSnapshot(s));

  static Future<BGreadingsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BGreadingsRecord.fromSnapshot(s));

  static BGreadingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BGreadingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BGreadingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BGreadingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BGreadingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BGreadingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBGreadingsRecordData({
  String? date,
  int? hour,
  int? minute,
  double? cGMreading,
  String? period,
  String? unit,
  double? decimalTime,
  String? time,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Date': date,
      'Hour': hour,
      'Minute': minute,
      'CGMreading': cGMreading,
      'Period': period,
      'Unit': unit,
      'DecimalTime': decimalTime,
      'Time': time,
    }.withoutNulls,
  );

  return firestoreData;
}

class BGreadingsRecordDocumentEquality implements Equality<BGreadingsRecord> {
  const BGreadingsRecordDocumentEquality();

  @override
  bool equals(BGreadingsRecord? e1, BGreadingsRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.hour == e2?.hour &&
        e1?.minute == e2?.minute &&
        e1?.cGMreading == e2?.cGMreading &&
        e1?.period == e2?.period &&
        e1?.unit == e2?.unit &&
        e1?.decimalTime == e2?.decimalTime &&
        e1?.time == e2?.time;
  }

  @override
  int hash(BGreadingsRecord? e) => const ListEquality().hash([
        e?.date,
        e?.hour,
        e?.minute,
        e?.cGMreading,
        e?.period,
        e?.unit,
        e?.decimalTime,
        e?.time
      ]);

  @override
  bool isValidKey(Object? o) => o is BGreadingsRecord;
}
