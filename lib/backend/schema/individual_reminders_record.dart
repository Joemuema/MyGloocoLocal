import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IndividualRemindersRecord extends FirestoreRecord {
  IndividualRemindersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "ReminderID" field.
  DocumentReference? _reminderID;
  DocumentReference? get reminderID => _reminderID;
  bool hasReminderID() => _reminderID != null;

  // "IsActive" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "Status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "Date" field.
  String? _date;
  String get date => _date ?? '';
  bool hasDate() => _date != null;

  // "Time" field.
  String? _time;
  String get time => _time ?? '';
  bool hasTime() => _time != null;

  // "NotificationID" field.
  int? _notificationID;
  int get notificationID => _notificationID ?? 0;
  bool hasNotificationID() => _notificationID != null;

  // "Title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "Content" field.
  String? _content;
  String get content => _content ?? '';
  bool hasContent() => _content != null;

  // "UserID" field.
  DocumentReference? _userID;
  DocumentReference? get userID => _userID;
  bool hasUserID() => _userID != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _reminderID = snapshotData['ReminderID'] as DocumentReference?;
    _isActive = snapshotData['IsActive'] as bool?;
    _status = snapshotData['Status'] as String?;
    _date = snapshotData['Date'] as String?;
    _time = snapshotData['Time'] as String?;
    _notificationID = castToType<int>(snapshotData['NotificationID']);
    _title = snapshotData['Title'] as String?;
    _content = snapshotData['Content'] as String?;
    _userID = snapshotData['UserID'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('IndividualReminders')
          : FirebaseFirestore.instance.collectionGroup('IndividualReminders');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('IndividualReminders').doc(id);

  static Stream<IndividualRemindersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => IndividualRemindersRecord.fromSnapshot(s));

  static Future<IndividualRemindersRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => IndividualRemindersRecord.fromSnapshot(s));

  static IndividualRemindersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      IndividualRemindersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static IndividualRemindersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      IndividualRemindersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'IndividualRemindersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is IndividualRemindersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createIndividualRemindersRecordData({
  DocumentReference? reminderID,
  bool? isActive,
  String? status,
  String? date,
  String? time,
  int? notificationID,
  String? title,
  String? content,
  DocumentReference? userID,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'ReminderID': reminderID,
      'IsActive': isActive,
      'Status': status,
      'Date': date,
      'Time': time,
      'NotificationID': notificationID,
      'Title': title,
      'Content': content,
      'UserID': userID,
    }.withoutNulls,
  );

  return firestoreData;
}

class IndividualRemindersRecordDocumentEquality
    implements Equality<IndividualRemindersRecord> {
  const IndividualRemindersRecordDocumentEquality();

  @override
  bool equals(IndividualRemindersRecord? e1, IndividualRemindersRecord? e2) {
    return e1?.reminderID == e2?.reminderID &&
        e1?.isActive == e2?.isActive &&
        e1?.status == e2?.status &&
        e1?.date == e2?.date &&
        e1?.time == e2?.time &&
        e1?.notificationID == e2?.notificationID &&
        e1?.title == e2?.title &&
        e1?.content == e2?.content &&
        e1?.userID == e2?.userID;
  }

  @override
  int hash(IndividualRemindersRecord? e) => const ListEquality().hash([
        e?.reminderID,
        e?.isActive,
        e?.status,
        e?.date,
        e?.time,
        e?.notificationID,
        e?.title,
        e?.content,
        e?.userID
      ]);

  @override
  bool isValidKey(Object? o) => o is IndividualRemindersRecord;
}
