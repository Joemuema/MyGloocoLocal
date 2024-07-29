import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StrengthexercisesRecord extends FirestoreRecord {
  StrengthexercisesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "Description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "weight" field.
  String? _weight;
  String get weight => _weight ?? '';
  bool hasWeight() => _weight != null;

  // "repetition" field.
  String? _repetition;
  String get repetition => _repetition ?? '';
  bool hasRepetition() => _repetition != null;

  // "sets" field.
  String? _sets;
  String get sets => _sets ?? '';
  bool hasSets() => _sets != null;

  // "rest" field.
  String? _rest;
  String get rest => _rest ?? '';
  bool hasRest() => _rest != null;

  // "duration" field.
  String? _duration;
  String get duration => _duration ?? '';
  bool hasDuration() => _duration != null;

  // "shortdescription" field.
  String? _shortdescription;
  String get shortdescription => _shortdescription ?? '';
  bool hasShortdescription() => _shortdescription != null;

  // "Type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _description = snapshotData['Description'] as String?;
    _image = snapshotData['image'] as String?;
    _weight = snapshotData['weight'] as String?;
    _repetition = snapshotData['repetition'] as String?;
    _sets = snapshotData['sets'] as String?;
    _rest = snapshotData['rest'] as String?;
    _duration = snapshotData['duration'] as String?;
    _shortdescription = snapshotData['shortdescription'] as String?;
    _type = snapshotData['Type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('strengthexercises');

  static Stream<StrengthexercisesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StrengthexercisesRecord.fromSnapshot(s));

  static Future<StrengthexercisesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => StrengthexercisesRecord.fromSnapshot(s));

  static StrengthexercisesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      StrengthexercisesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StrengthexercisesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StrengthexercisesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StrengthexercisesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StrengthexercisesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStrengthexercisesRecordData({
  String? name,
  String? description,
  String? image,
  String? weight,
  String? repetition,
  String? sets,
  String? rest,
  String? duration,
  String? shortdescription,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'Description': description,
      'image': image,
      'weight': weight,
      'repetition': repetition,
      'sets': sets,
      'rest': rest,
      'duration': duration,
      'shortdescription': shortdescription,
      'Type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class StrengthexercisesRecordDocumentEquality
    implements Equality<StrengthexercisesRecord> {
  const StrengthexercisesRecordDocumentEquality();

  @override
  bool equals(StrengthexercisesRecord? e1, StrengthexercisesRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.image == e2?.image &&
        e1?.weight == e2?.weight &&
        e1?.repetition == e2?.repetition &&
        e1?.sets == e2?.sets &&
        e1?.rest == e2?.rest &&
        e1?.duration == e2?.duration &&
        e1?.shortdescription == e2?.shortdescription &&
        e1?.type == e2?.type;
  }

  @override
  int hash(StrengthexercisesRecord? e) => const ListEquality().hash([
        e?.name,
        e?.description,
        e?.image,
        e?.weight,
        e?.repetition,
        e?.sets,
        e?.rest,
        e?.duration,
        e?.shortdescription,
        e?.type
      ]);

  @override
  bool isValidKey(Object? o) => o is StrengthexercisesRecord;
}
