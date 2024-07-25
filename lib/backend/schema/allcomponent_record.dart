import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AllcomponentRecord extends FirestoreRecord {
  AllcomponentRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "intensity" field.
  String? _intensity;
  String get intensity => _intensity ?? '';
  bool hasIntensity() => _intensity != null;

  // "starttime" field.
  DateTime? _starttime;
  DateTime? get starttime => _starttime;
  bool hasStarttime() => _starttime != null;

  // "finishtime" field.
  DateTime? _finishtime;
  DateTime? get finishtime => _finishtime;
  bool hasFinishtime() => _finishtime != null;

  // "workshedule" field.
  DateTime? _workshedule;
  DateTime? get workshedule => _workshedule;
  bool hasWorkshedule() => _workshedule != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  void _initializeFields() {
    _image = snapshotData['image'] as String?;
    _description = snapshotData['description'] as String?;
    _intensity = snapshotData['intensity'] as String?;
    _starttime = snapshotData['starttime'] as DateTime?;
    _finishtime = snapshotData['finishtime'] as DateTime?;
    _workshedule = snapshotData['workshedule'] as DateTime?;
    _name = snapshotData['name'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('allcomponent');

  static Stream<AllcomponentRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AllcomponentRecord.fromSnapshot(s));

  static Future<AllcomponentRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AllcomponentRecord.fromSnapshot(s));

  static AllcomponentRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AllcomponentRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AllcomponentRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AllcomponentRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AllcomponentRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AllcomponentRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAllcomponentRecordData({
  String? image,
  String? description,
  String? intensity,
  DateTime? starttime,
  DateTime? finishtime,
  DateTime? workshedule,
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'image': image,
      'description': description,
      'intensity': intensity,
      'starttime': starttime,
      'finishtime': finishtime,
      'workshedule': workshedule,
      'name': name,
    }.withoutNulls,
  );

  return firestoreData;
}

class AllcomponentRecordDocumentEquality
    implements Equality<AllcomponentRecord> {
  const AllcomponentRecordDocumentEquality();

  @override
  bool equals(AllcomponentRecord? e1, AllcomponentRecord? e2) {
    return e1?.image == e2?.image &&
        e1?.description == e2?.description &&
        e1?.intensity == e2?.intensity &&
        e1?.starttime == e2?.starttime &&
        e1?.finishtime == e2?.finishtime &&
        e1?.workshedule == e2?.workshedule &&
        e1?.name == e2?.name;
  }

  @override
  int hash(AllcomponentRecord? e) => const ListEquality().hash([
        e?.image,
        e?.description,
        e?.intensity,
        e?.starttime,
        e?.finishtime,
        e?.workshedule,
        e?.name
      ]);

  @override
  bool isValidKey(Object? o) => o is AllcomponentRecord;
}
