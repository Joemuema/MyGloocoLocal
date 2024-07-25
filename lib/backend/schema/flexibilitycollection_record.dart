import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FlexibilitycollectionRecord extends FirestoreRecord {
  FlexibilitycollectionRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "duration" field.
  String? _duration;
  String get duration => _duration ?? '';
  bool hasDuration() => _duration != null;

  // "sets" field.
  String? _sets;
  String get sets => _sets ?? '';
  bool hasSets() => _sets != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "howto" field.
  String? _howto;
  String get howto => _howto ?? '';
  bool hasHowto() => _howto != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _duration = snapshotData['duration'] as String?;
    _sets = snapshotData['sets'] as String?;
    _image = snapshotData['image'] as String?;
    _howto = snapshotData['howto'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('flexibilitycollection');

  static Stream<FlexibilitycollectionRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => FlexibilitycollectionRecord.fromSnapshot(s));

  static Future<FlexibilitycollectionRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => FlexibilitycollectionRecord.fromSnapshot(s));

  static FlexibilitycollectionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FlexibilitycollectionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FlexibilitycollectionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FlexibilitycollectionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FlexibilitycollectionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FlexibilitycollectionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFlexibilitycollectionRecordData({
  String? name,
  String? description,
  String? duration,
  String? sets,
  String? image,
  String? howto,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'description': description,
      'duration': duration,
      'sets': sets,
      'image': image,
      'howto': howto,
    }.withoutNulls,
  );

  return firestoreData;
}

class FlexibilitycollectionRecordDocumentEquality
    implements Equality<FlexibilitycollectionRecord> {
  const FlexibilitycollectionRecordDocumentEquality();

  @override
  bool equals(
      FlexibilitycollectionRecord? e1, FlexibilitycollectionRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.duration == e2?.duration &&
        e1?.sets == e2?.sets &&
        e1?.image == e2?.image &&
        e1?.howto == e2?.howto;
  }

  @override
  int hash(FlexibilitycollectionRecord? e) => const ListEquality().hash(
      [e?.name, e?.description, e?.duration, e?.sets, e?.image, e?.howto]);

  @override
  bool isValidKey(Object? o) => o is FlexibilitycollectionRecord;
}
