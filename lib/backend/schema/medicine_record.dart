import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MedicineRecord extends FirestoreRecord {
  MedicineRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "Description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "Form" field.
  String? _form;
  String get form => _form ?? '';
  bool hasForm() => _form != null;

  // "SingleDose" field.
  double? _singleDose;
  double get singleDose => _singleDose ?? 0.0;
  bool hasSingleDose() => _singleDose != null;

  // "TotalDose" field.
  double? _totalDose;
  double get totalDose => _totalDose ?? 0.0;
  bool hasTotalDose() => _totalDose != null;

  // "SetReminders" field.
  bool? _setReminders;
  bool get setReminders => _setReminders ?? false;
  bool hasSetReminders() => _setReminders != null;

  // "UserID" field.
  DocumentReference? _userID;
  DocumentReference? get userID => _userID;
  bool hasUserID() => _userID != null;

  // "StartDate" field.
  String? _startDate;
  String get startDate => _startDate ?? '';
  bool hasStartDate() => _startDate != null;

  // "EndDate" field.
  String? _endDate;
  String get endDate => _endDate ?? '';
  bool hasEndDate() => _endDate != null;

  // "MedId" field.
  DocumentReference? _medId;
  DocumentReference? get medId => _medId;
  bool hasMedId() => _medId != null;

  void _initializeFields() {
    _name = snapshotData['Name'] as String?;
    _description = snapshotData['Description'] as String?;
    _form = snapshotData['Form'] as String?;
    _singleDose = castToType<double>(snapshotData['SingleDose']);
    _totalDose = castToType<double>(snapshotData['TotalDose']);
    _setReminders = snapshotData['SetReminders'] as bool?;
    _userID = snapshotData['UserID'] as DocumentReference?;
    _startDate = snapshotData['StartDate'] as String?;
    _endDate = snapshotData['EndDate'] as String?;
    _medId = snapshotData['MedId'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Medicine');

  static Stream<MedicineRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MedicineRecord.fromSnapshot(s));

  static Future<MedicineRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MedicineRecord.fromSnapshot(s));

  static MedicineRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MedicineRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MedicineRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MedicineRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MedicineRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MedicineRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMedicineRecordData({
  String? name,
  String? description,
  String? form,
  double? singleDose,
  double? totalDose,
  bool? setReminders,
  DocumentReference? userID,
  String? startDate,
  String? endDate,
  DocumentReference? medId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Name': name,
      'Description': description,
      'Form': form,
      'SingleDose': singleDose,
      'TotalDose': totalDose,
      'SetReminders': setReminders,
      'UserID': userID,
      'StartDate': startDate,
      'EndDate': endDate,
      'MedId': medId,
    }.withoutNulls,
  );

  return firestoreData;
}

class MedicineRecordDocumentEquality implements Equality<MedicineRecord> {
  const MedicineRecordDocumentEquality();

  @override
  bool equals(MedicineRecord? e1, MedicineRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.form == e2?.form &&
        e1?.singleDose == e2?.singleDose &&
        e1?.totalDose == e2?.totalDose &&
        e1?.setReminders == e2?.setReminders &&
        e1?.userID == e2?.userID &&
        e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate &&
        e1?.medId == e2?.medId;
  }

  @override
  int hash(MedicineRecord? e) => const ListEquality().hash([
        e?.name,
        e?.description,
        e?.form,
        e?.singleDose,
        e?.totalDose,
        e?.setReminders,
        e?.userID,
        e?.startDate,
        e?.endDate,
        e?.medId
      ]);

  @override
  bool isValidKey(Object? o) => o is MedicineRecord;
}
