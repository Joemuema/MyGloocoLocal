import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RemindersRecord extends FirestoreRecord {
  RemindersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "MedicineID" field.
  DocumentReference? _medicineID;
  DocumentReference? get medicineID => _medicineID;
  bool hasMedicineID() => _medicineID != null;

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "SnoozeDuration" field.
  int? _snoozeDuration;
  int get snoozeDuration => _snoozeDuration ?? 0;
  bool hasSnoozeDuration() => _snoozeDuration != null;

  // "UserID" field.
  DocumentReference? _userID;
  DocumentReference? get userID => _userID;
  bool hasUserID() => _userID != null;

  // "Day" field.
  String? _day;
  String get day => _day ?? '';
  bool hasDay() => _day != null;

  // "AutoSet" field.
  bool? _autoSet;
  bool get autoSet => _autoSet ?? false;
  bool hasAutoSet() => _autoSet != null;

  // "Frequency" field.
  String? _frequency;
  String get frequency => _frequency ?? '';
  bool hasFrequency() => _frequency != null;

  // "DateNumber" field.
  int? _dateNumber;
  int get dateNumber => _dateNumber ?? 0;
  bool hasDateNumber() => _dateNumber != null;

  // "Date" field.
  String? _date;
  String get date => _date ?? '';
  bool hasDate() => _date != null;

  // "Time" field.
  String? _time;
  String get time => _time ?? '';
  bool hasTime() => _time != null;

  // "FirstDate" field.
  String? _firstDate;
  String get firstDate => _firstDate ?? '';
  bool hasFirstDate() => _firstDate != null;

  // "LastDate" field.
  String? _lastDate;
  String get lastDate => _lastDate ?? '';
  bool hasLastDate() => _lastDate != null;

  // "SetCustomDates" field.
  bool? _setCustomDates;
  bool get setCustomDates => _setCustomDates ?? false;
  bool hasSetCustomDates() => _setCustomDates != null;

  // "DateTimeCreated" field.
  DateTime? _dateTimeCreated;
  DateTime? get dateTimeCreated => _dateTimeCreated;
  bool hasDateTimeCreated() => _dateTimeCreated != null;

  // "FIrstDateTime" field.
  DateTime? _fIrstDateTime;
  DateTime? get fIrstDateTime => _fIrstDateTime;
  bool hasFIrstDateTime() => _fIrstDateTime != null;

  // "LastDateTime" field.
  DateTime? _lastDateTime;
  DateTime? get lastDateTime => _lastDateTime;
  bool hasLastDateTime() => _lastDateTime != null;

  // "TimeDT" field.
  DateTime? _timeDT;
  DateTime? get timeDT => _timeDT;
  bool hasTimeDT() => _timeDT != null;

  // "lastUpdated" field.
  DateTime? _lastUpdated;
  DateTime? get lastUpdated => _lastUpdated;
  bool hasLastUpdated() => _lastUpdated != null;

  void _initializeFields() {
    _medicineID = snapshotData['MedicineID'] as DocumentReference?;
    _name = snapshotData['Name'] as String?;
    _snoozeDuration = castToType<int>(snapshotData['SnoozeDuration']);
    _userID = snapshotData['UserID'] as DocumentReference?;
    _day = snapshotData['Day'] as String?;
    _autoSet = snapshotData['AutoSet'] as bool?;
    _frequency = snapshotData['Frequency'] as String?;
    _dateNumber = castToType<int>(snapshotData['DateNumber']);
    _date = snapshotData['Date'] as String?;
    _time = snapshotData['Time'] as String?;
    _firstDate = snapshotData['FirstDate'] as String?;
    _lastDate = snapshotData['LastDate'] as String?;
    _setCustomDates = snapshotData['SetCustomDates'] as bool?;
    _dateTimeCreated = snapshotData['DateTimeCreated'] as DateTime?;
    _fIrstDateTime = snapshotData['FIrstDateTime'] as DateTime?;
    _lastDateTime = snapshotData['LastDateTime'] as DateTime?;
    _timeDT = snapshotData['TimeDT'] as DateTime?;
    _lastUpdated = snapshotData['lastUpdated'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Reminders');

  static Stream<RemindersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RemindersRecord.fromSnapshot(s));

  static Future<RemindersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RemindersRecord.fromSnapshot(s));

  static RemindersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RemindersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RemindersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RemindersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RemindersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RemindersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRemindersRecordData({
  DocumentReference? medicineID,
  String? name,
  int? snoozeDuration,
  DocumentReference? userID,
  String? day,
  bool? autoSet,
  String? frequency,
  int? dateNumber,
  String? date,
  String? time,
  String? firstDate,
  String? lastDate,
  bool? setCustomDates,
  DateTime? dateTimeCreated,
  DateTime? fIrstDateTime,
  DateTime? lastDateTime,
  DateTime? timeDT,
  DateTime? lastUpdated,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'MedicineID': medicineID,
      'Name': name,
      'SnoozeDuration': snoozeDuration,
      'UserID': userID,
      'Day': day,
      'AutoSet': autoSet,
      'Frequency': frequency,
      'DateNumber': dateNumber,
      'Date': date,
      'Time': time,
      'FirstDate': firstDate,
      'LastDate': lastDate,
      'SetCustomDates': setCustomDates,
      'DateTimeCreated': dateTimeCreated,
      'FIrstDateTime': fIrstDateTime,
      'LastDateTime': lastDateTime,
      'TimeDT': timeDT,
      'lastUpdated': lastUpdated,
    }.withoutNulls,
  );

  return firestoreData;
}

class RemindersRecordDocumentEquality implements Equality<RemindersRecord> {
  const RemindersRecordDocumentEquality();

  @override
  bool equals(RemindersRecord? e1, RemindersRecord? e2) {
    return e1?.medicineID == e2?.medicineID &&
        e1?.name == e2?.name &&
        e1?.snoozeDuration == e2?.snoozeDuration &&
        e1?.userID == e2?.userID &&
        e1?.day == e2?.day &&
        e1?.autoSet == e2?.autoSet &&
        e1?.frequency == e2?.frequency &&
        e1?.dateNumber == e2?.dateNumber &&
        e1?.date == e2?.date &&
        e1?.time == e2?.time &&
        e1?.firstDate == e2?.firstDate &&
        e1?.lastDate == e2?.lastDate &&
        e1?.setCustomDates == e2?.setCustomDates &&
        e1?.dateTimeCreated == e2?.dateTimeCreated &&
        e1?.fIrstDateTime == e2?.fIrstDateTime &&
        e1?.lastDateTime == e2?.lastDateTime &&
        e1?.timeDT == e2?.timeDT &&
        e1?.lastUpdated == e2?.lastUpdated;
  }

  @override
  int hash(RemindersRecord? e) => const ListEquality().hash([
        e?.medicineID,
        e?.name,
        e?.snoozeDuration,
        e?.userID,
        e?.day,
        e?.autoSet,
        e?.frequency,
        e?.dateNumber,
        e?.date,
        e?.time,
        e?.firstDate,
        e?.lastDate,
        e?.setCustomDates,
        e?.dateTimeCreated,
        e?.fIrstDateTime,
        e?.lastDateTime,
        e?.timeDT,
        e?.lastUpdated
      ]);

  @override
  bool isValidKey(Object? o) => o is RemindersRecord;
}
