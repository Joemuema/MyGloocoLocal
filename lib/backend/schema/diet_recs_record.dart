import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DietRecsRecord extends FirestoreRecord {
  DietRecsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Group" field.
  String? _group;
  String get group => _group ?? '';
  bool hasGroup() => _group != null;

  // "ApproxCals" field.
  String? _approxCals;
  String get approxCals => _approxCals ?? '';
  bool hasApproxCals() => _approxCals != null;

  // "GramsAvg" field.
  String? _gramsAvg;
  String get gramsAvg => _gramsAvg ?? '';
  bool hasGramsAvg() => _gramsAvg != null;

  // "Recs" field.
  String? _recs;
  String get recs => _recs ?? '';
  bool hasRecs() => _recs != null;

  void _initializeFields() {
    _group = snapshotData['Group'] as String?;
    _approxCals = snapshotData['ApproxCals'] as String?;
    _gramsAvg = snapshotData['GramsAvg'] as String?;
    _recs = snapshotData['Recs'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('DietRecs');

  static Stream<DietRecsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DietRecsRecord.fromSnapshot(s));

  static Future<DietRecsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DietRecsRecord.fromSnapshot(s));

  static DietRecsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DietRecsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DietRecsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DietRecsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DietRecsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DietRecsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDietRecsRecordData({
  String? group,
  String? approxCals,
  String? gramsAvg,
  String? recs,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Group': group,
      'ApproxCals': approxCals,
      'GramsAvg': gramsAvg,
      'Recs': recs,
    }.withoutNulls,
  );

  return firestoreData;
}

class DietRecsRecordDocumentEquality implements Equality<DietRecsRecord> {
  const DietRecsRecordDocumentEquality();

  @override
  bool equals(DietRecsRecord? e1, DietRecsRecord? e2) {
    return e1?.group == e2?.group &&
        e1?.approxCals == e2?.approxCals &&
        e1?.gramsAvg == e2?.gramsAvg &&
        e1?.recs == e2?.recs;
  }

  @override
  int hash(DietRecsRecord? e) => const ListEquality()
      .hash([e?.group, e?.approxCals, e?.gramsAvg, e?.recs]);

  @override
  bool isValidKey(Object? o) => o is DietRecsRecord;
}
