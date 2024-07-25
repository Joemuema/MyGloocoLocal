import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AerobicrunningcollectionRecord extends FirestoreRecord {
  AerobicrunningcollectionRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "intensity" field.
  String? _intensity;
  String get intensity => _intensity ?? '';
  bool hasIntensity() => _intensity != null;

  // "Duration" field.
  String? _duration;
  String get duration => _duration ?? '';
  bool hasDuration() => _duration != null;

  // "Muscelsused" field.
  String? _muscelsused;
  String get muscelsused => _muscelsused ?? '';
  bool hasMuscelsused() => _muscelsused != null;

  // "considerations" field.
  String? _considerations;
  String get considerations => _considerations ?? '';
  bool hasConsiderations() => _considerations != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _intensity = snapshotData['intensity'] as String?;
    _duration = snapshotData['Duration'] as String?;
    _muscelsused = snapshotData['Muscelsused'] as String?;
    _considerations = snapshotData['considerations'] as String?;
    _name = snapshotData['name'] as String?;
    _type = snapshotData['type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Aerobicrunningcollection');

  static Stream<AerobicrunningcollectionRecord> getDocument(
          DocumentReference ref) =>
      ref
          .snapshots()
          .map((s) => AerobicrunningcollectionRecord.fromSnapshot(s));

  static Future<AerobicrunningcollectionRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => AerobicrunningcollectionRecord.fromSnapshot(s));

  static AerobicrunningcollectionRecord fromSnapshot(
          DocumentSnapshot snapshot) =>
      AerobicrunningcollectionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AerobicrunningcollectionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AerobicrunningcollectionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AerobicrunningcollectionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AerobicrunningcollectionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAerobicrunningcollectionRecordData({
  String? intensity,
  String? duration,
  String? muscelsused,
  String? considerations,
  String? name,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'intensity': intensity,
      'Duration': duration,
      'Muscelsused': muscelsused,
      'considerations': considerations,
      'name': name,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class AerobicrunningcollectionRecordDocumentEquality
    implements Equality<AerobicrunningcollectionRecord> {
  const AerobicrunningcollectionRecordDocumentEquality();

  @override
  bool equals(
      AerobicrunningcollectionRecord? e1, AerobicrunningcollectionRecord? e2) {
    return e1?.intensity == e2?.intensity &&
        e1?.duration == e2?.duration &&
        e1?.muscelsused == e2?.muscelsused &&
        e1?.considerations == e2?.considerations &&
        e1?.name == e2?.name &&
        e1?.type == e2?.type;
  }

  @override
  int hash(AerobicrunningcollectionRecord? e) => const ListEquality().hash([
        e?.intensity,
        e?.duration,
        e?.muscelsused,
        e?.considerations,
        e?.name,
        e?.type
      ]);

  @override
  bool isValidKey(Object? o) => o is AerobicrunningcollectionRecord;
}
