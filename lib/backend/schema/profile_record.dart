import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProfileRecord extends FirestoreRecord {
  ProfileRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "profilepic" field.
  String? _profilepic;
  String get profilepic => _profilepic ?? '';
  bool hasProfilepic() => _profilepic != null;

  // "Firstname" field.
  String? _firstname;
  String get firstname => _firstname ?? '';
  bool hasFirstname() => _firstname != null;

  // "Lastname" field.
  String? _lastname;
  String get lastname => _lastname ?? '';
  bool hasLastname() => _lastname != null;

  // "date_created" field.
  DateTime? _dateCreated;
  DateTime? get dateCreated => _dateCreated;
  bool hasDateCreated() => _dateCreated != null;

  // "Gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "preferredBG" field.
  String? _preferredBG;
  String get preferredBG => _preferredBG ?? '';
  bool hasPreferredBG() => _preferredBG != null;

  // "preferredCal" field.
  String? _preferredCal;
  String get preferredCal => _preferredCal ?? '';
  bool hasPreferredCal() => _preferredCal != null;

  // "diabetesType" field.
  String? _diabetesType;
  String get diabetesType => _diabetesType ?? '';
  bool hasDiabetesType() => _diabetesType != null;

  // "insulinTherapy" field.
  String? _insulinTherapy;
  String get insulinTherapy => _insulinTherapy ?? '';
  bool hasInsulinTherapy() => _insulinTherapy != null;

  // "uid" field.
  DocumentReference? _uid;
  DocumentReference? get uid => _uid;
  bool hasUid() => _uid != null;

  // "phoneNumber" field.
  int? _phoneNumber;
  int get phoneNumber => _phoneNumber ?? 0;
  bool hasPhoneNumber() => _phoneNumber != null;

  void _initializeFields() {
    _profilepic = snapshotData['profilepic'] as String?;
    _firstname = snapshotData['Firstname'] as String?;
    _lastname = snapshotData['Lastname'] as String?;
    _dateCreated = snapshotData['date_created'] as DateTime?;
    _gender = snapshotData['Gender'] as String?;
    _preferredBG = snapshotData['preferredBG'] as String?;
    _preferredCal = snapshotData['preferredCal'] as String?;
    _diabetesType = snapshotData['diabetesType'] as String?;
    _insulinTherapy = snapshotData['insulinTherapy'] as String?;
    _uid = snapshotData['uid'] as DocumentReference?;
    _phoneNumber = castToType<int>(snapshotData['phoneNumber']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('profile');

  static Stream<ProfileRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProfileRecord.fromSnapshot(s));

  static Future<ProfileRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProfileRecord.fromSnapshot(s));

  static ProfileRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProfileRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProfileRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProfileRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProfileRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProfileRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProfileRecordData({
  String? profilepic,
  String? firstname,
  String? lastname,
  DateTime? dateCreated,
  String? gender,
  String? preferredBG,
  String? preferredCal,
  String? diabetesType,
  String? insulinTherapy,
  DocumentReference? uid,
  int? phoneNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'profilepic': profilepic,
      'Firstname': firstname,
      'Lastname': lastname,
      'date_created': dateCreated,
      'Gender': gender,
      'preferredBG': preferredBG,
      'preferredCal': preferredCal,
      'diabetesType': diabetesType,
      'insulinTherapy': insulinTherapy,
      'uid': uid,
      'phoneNumber': phoneNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProfileRecordDocumentEquality implements Equality<ProfileRecord> {
  const ProfileRecordDocumentEquality();

  @override
  bool equals(ProfileRecord? e1, ProfileRecord? e2) {
    return e1?.profilepic == e2?.profilepic &&
        e1?.firstname == e2?.firstname &&
        e1?.lastname == e2?.lastname &&
        e1?.dateCreated == e2?.dateCreated &&
        e1?.gender == e2?.gender &&
        e1?.preferredBG == e2?.preferredBG &&
        e1?.preferredCal == e2?.preferredCal &&
        e1?.diabetesType == e2?.diabetesType &&
        e1?.insulinTherapy == e2?.insulinTherapy &&
        e1?.uid == e2?.uid &&
        e1?.phoneNumber == e2?.phoneNumber;
  }

  @override
  int hash(ProfileRecord? e) => const ListEquality().hash([
        e?.profilepic,
        e?.firstname,
        e?.lastname,
        e?.dateCreated,
        e?.gender,
        e?.preferredBG,
        e?.preferredCal,
        e?.diabetesType,
        e?.insulinTherapy,
        e?.uid,
        e?.phoneNumber
      ]);

  @override
  bool isValidKey(Object? o) => o is ProfileRecord;
}
