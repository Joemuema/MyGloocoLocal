import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReportsRecord extends FirestoreRecord {
  ReportsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "StartDate" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "EndDate" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  // "ReportId" field.
  String? _reportId;
  String get reportId => _reportId ?? '';
  bool hasReportId() => _reportId != null;

  void _initializeFields() {
    _startDate = snapshotData['StartDate'] as DateTime?;
    _endDate = snapshotData['EndDate'] as DateTime?;
    _reportId = snapshotData['ReportId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Reports');

  static Stream<ReportsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReportsRecord.fromSnapshot(s));

  static Future<ReportsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReportsRecord.fromSnapshot(s));

  static ReportsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReportsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReportsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReportsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReportsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReportsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReportsRecordData({
  DateTime? startDate,
  DateTime? endDate,
  String? reportId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'StartDate': startDate,
      'EndDate': endDate,
      'ReportId': reportId,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReportsRecordDocumentEquality implements Equality<ReportsRecord> {
  const ReportsRecordDocumentEquality();

  @override
  bool equals(ReportsRecord? e1, ReportsRecord? e2) {
    return e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate &&
        e1?.reportId == e2?.reportId;
  }

  @override
  int hash(ReportsRecord? e) =>
      const ListEquality().hash([e?.startDate, e?.endDate, e?.reportId]);

  @override
  bool isValidKey(Object? o) => o is ReportsRecord;
}
