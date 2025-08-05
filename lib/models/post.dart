import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String id;
  String description;
  String? mediaUrl;
  bool isVideo;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  bool isActive;
  String searchKey;
  List viewers;
  PostModel({
    required this.id,
    required this.description,
    required this.mediaUrl,
    required this.isVideo,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.isActive,
    required this.searchKey,
    required this.viewers,
  });
  PostModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
    : id = snapshot.id,
      description = snapshot['description'] ?? "",
      mediaUrl = snapshot['mediaUrl'] ?? "",
      isVideo = snapshot['isVideo'] ?? false,
      isActive = snapshot['isActive'] ?? false,
      viewers = snapshot['viewers'] ?? [],
      searchKey = snapshot['searchKey'] ?? "",
      createdAt = snapshot['createdAt']?.toDate() ?? DateTime.now(),
      updatedAt = snapshot['updatedAt']?.toDate() ?? DateTime.now(),
      createdBy = snapshot['createdBy'] ?? "";

  Map<String, dynamic> toJson() => {
    "description": description,
    "mediaUrl": mediaUrl,
    "isVideo": isVideo,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "createdBy": createdBy,
    "searchKey": searchKey,
    "isActive": isActive,
    "viewers": viewers,
  };
}
