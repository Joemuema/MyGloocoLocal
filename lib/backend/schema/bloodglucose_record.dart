import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BloodglucoseRecord extends FirestoreRecord {
  BloodglucoseRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Period" field.
  String? _period;
  String get period => _period ?? '';
  bool hasPeriod() => _period != null;

  // "Timetaken" field.
  DateTime? _timetaken;
  DateTime? get timetaken => _timetaken;
  bool hasTimetaken() => _timetaken != null;

  // "bgreading" field.
  double? _bgreading;
  double get bgreading => _bgreading ?? 0.0;
  bool hasBgreading() => _bgreading != null;

  // "Units" field.
  String? _units;
  String get units => _units ?? '';
  bool hasUnits() => _units != null;

  // "uid" field.
  DocumentReference? _uid;
  DocumentReference? get uid => _uid;
  bool hasUid() => _uid != null;

  void _initializeFields() {
    _period = snapshotData['Period'] as String?;
    _timetaken = snapshotData['Timetaken'] as DateTime?;
    _bgreading = castToType<double>(snapshotData['bgreading']);
    _units = snapshotData['Units'] as String?;
    _uid = snapshotData['uid'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('bloodglucose');

  static Stream<BloodglucoseRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BloodglucoseRecord.fromSnapshot(s));

  static Future<BloodglucoseRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BloodglucoseRecord.fromSnapshot(s));

  static BloodglucoseRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BloodglucoseRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BloodglucoseRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BloodglucoseRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BloodglucoseRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BloodglucoseRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBloodglucoseRecordData({
  String? period,
  DateTime? timetaken,
  double? bgreading,
  String? units,
  DocumentReference? uid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Period': period,
      'Timetaken': timetaken,
      'bgreading': bgreading,
      'Units': units,
      'uid': uid,
    }.withoutNulls,
  );

  return firestoreData;
}

class BloodglucoseRecordDocumentEquality
    implements Equality<BloodglucoseRecord> {
  const BloodglucoseRecordDocumentEquality();

  @override
  bool equals(BloodglucoseRecord? e1, BloodglucoseRecord? e2) {
    return e1?.period == e2?.period &&
        e1?.timetaken == e2?.timetaken &&
        e1?.bgreading == e2?.bgreading &&
        e1?.units == e2?.units &&
        e1?.uid == e2?.uid;
  }

  @override
  int hash(BloodglucoseRecord? e) => const ListEquality()
      .hash([e?.period, e?.timetaken, e?.bgreading, e?.units, e?.uid]);

  @override
  bool isValidKey(Object? o) => o is BloodglucoseRecord;
}
