import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SampleBGreadingsRecord extends FirestoreRecord {
  SampleBGreadingsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "CGMreadings" field.
  double? _cGMreadings;
  double get cGMreadings => _cGMreadings ?? 0.0;
  bool hasCGMreadings() => _cGMreadings != null;

  // "Period" field.
  String? _period;
  String get period => _period ?? '';
  bool hasPeriod() => _period != null;

  // "Date" field.
  String? _date;
  String get date => _date ?? '';
  bool hasDate() => _date != null;

  // "Time" field.
  String? _time;
  String get time => _time ?? '';
  bool hasTime() => _time != null;

  void _initializeFields() {
    _cGMreadings = castToType<double>(snapshotData['CGMreadings']);
    _period = snapshotData['Period'] as String?;
    _date = snapshotData['Date'] as String?;
    _time = snapshotData['Time'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('sampleBGreadings');

  static Stream<SampleBGreadingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SampleBGreadingsRecord.fromSnapshot(s));

  static Future<SampleBGreadingsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => SampleBGreadingsRecord.fromSnapshot(s));

  static SampleBGreadingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SampleBGreadingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SampleBGreadingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SampleBGreadingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SampleBGreadingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SampleBGreadingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSampleBGreadingsRecordData({
  double? cGMreadings,
  String? period,
  String? date,
  String? time,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'CGMreadings': cGMreadings,
      'Period': period,
      'Date': date,
      'Time': time,
    }.withoutNulls,
  );

  return firestoreData;
}

class SampleBGreadingsRecordDocumentEquality
    implements Equality<SampleBGreadingsRecord> {
  const SampleBGreadingsRecordDocumentEquality();

  @override
  bool equals(SampleBGreadingsRecord? e1, SampleBGreadingsRecord? e2) {
    return e1?.cGMreadings == e2?.cGMreadings &&
        e1?.period == e2?.period &&
        e1?.date == e2?.date &&
        e1?.time == e2?.time;
  }

  @override
  int hash(SampleBGreadingsRecord? e) =>
      const ListEquality().hash([e?.cGMreadings, e?.period, e?.date, e?.time]);

  @override
  bool isValidKey(Object? o) => o is SampleBGreadingsRecord;
}
