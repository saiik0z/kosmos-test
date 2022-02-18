import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'picture_users_record.g.dart';

abstract class PictureUsersRecord
    implements Built<PictureUsersRecord, PictureUsersRecordBuilder> {
  static Serializer<PictureUsersRecord> get serializer =>
      _$pictureUsersRecordSerializer;

  @nullable
  String get pictures;

  @nullable
  @BuiltValueField(wireName: 'photos_url')
  DocumentReference get photosUrl;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PictureUsersRecordBuilder builder) =>
      builder..pictures = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Picture-Users');

  static Stream<PictureUsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<PictureUsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  PictureUsersRecord._();
  factory PictureUsersRecord(
          [void Function(PictureUsersRecordBuilder) updates]) =
      _$PictureUsersRecord;

  static PictureUsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPictureUsersRecordData({
  String pictures,
  DocumentReference photosUrl,
}) =>
    serializers.toFirestore(
        PictureUsersRecord.serializer,
        PictureUsersRecord((p) => p
          ..pictures = pictures
          ..photosUrl = photosUrl));
