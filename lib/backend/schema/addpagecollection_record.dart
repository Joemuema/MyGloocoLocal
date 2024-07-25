import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AddpagecollectionRecord extends FirestoreRecord {
  AddpagecollectionRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "activity" field.
  String? _activity;
  String get activity => _activity ?? '';
  bool hasActivity() => _activity != null;

  // "weight" field.
  double? _weight;
  double get weight => _weight ?? 0.0;
  bool hasWeight() => _weight != null;

  // "distance" field.
  double? _distance;
  double get distance => _distance ?? 0.0;
  bool hasDistance() => _distance != null;

  // "start_time" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "finish_time" field.
  DateTime? _finishTime;
  DateTime? get finishTime => _finishTime;
  bool hasFinishTime() => _finishTime != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "intensity" field.
  String? _intensity;
  String get intensity => _intensity ?? '';
  bool hasIntensity() => _intensity != null;

  // "completed" field.
  bool? _completed;
  bool get completed => _completed ?? false;
  bool hasCompleted() => _completed != null;

  void _initializeFields() {
    _activity = snapshotData['activity'] as String?;
    _weight = castToType<double>(snapshotData['weight']);
    _distance = castToType<double>(snapshotData['distance']);
    _startTime = snapshotData['start_time'] as DateTime?;
    _finishTime = snapshotData['finish_time'] as DateTime?;
    _date = snapshotData['date'] as DateTime?;
    _intensity = snapshotData['intensity'] as String?;
    _completed = snapshotData['completed'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('addpagecollection');

  static Stream<AddpagecollectionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AddpagecollectionRecord.fromSnapshot(s));

  static Future<AddpagecollectionRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => AddpagecollectionRecord.fromSnapshot(s));

  static AddpagecollectionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AddpagecollectionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AddpagecollectionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AddpagecollectionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AddpagecollectionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AddpagecollectionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAddpagecollectionRecordData({
  String? activity,
  double? weight,
  double? distance,
  DateTime? startTime,
  DateTime? finishTime,
  DateTime? date,
  String? intensity,
  bool? completed,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'activity': activity,
      'weight': weight,
      'distance': distance,
      'start_time': startTime,
      'finish_time': finishTime,
      'date': date,
      'intensity': intensity,
      'completed': completed,
    }.withoutNulls,
  );

  return firestoreData;
}

class AddpagecollectionRecordDocumentEquality
    implements Equality<AddpagecollectionRecord> {
  const AddpagecollectionRecordDocumentEquality();

  @override
  bool equals(AddpagecollectionRecord? e1, AddpagecollectionRecord? e2) {
    return e1?.activity == e2?.activity &&
        e1?.weight == e2?.weight &&
        e1?.distance == e2?.distance &&
        e1?.startTime == e2?.startTime &&
        e1?.finishTime == e2?.finishTime &&
        e1?.date == e2?.date &&
        e1?.intensity == e2?.intensity &&
        e1?.completed == e2?.completed;
  }

  @override
  int hash(AddpagecollectionRecord? e) => const ListEquality().hash([
        e?.activity,
        e?.weight,
        e?.distance,
        e?.startTime,
        e?.finishTime,
        e?.date,
        e?.intensity,
        e?.completed
      ]);

  @override
  bool isValidKey(Object? o) => o is AddpagecollectionRecord;
}
