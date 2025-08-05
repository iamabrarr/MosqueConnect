import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String? mosqueImage;
  //For members its members name and for mosque its mosque name
  final String name;
  final String email;
  final String mosqueID;
  final String mosqueAddress;
  //createdAt and updatedAt are storing in UTC
  final DateTime createdAt;
  final DateTime updatedAt;
  final int postsCount;
  final UserRole role;
  //used to send push notification to the user
  final String? fcmToken;
  final bool isLoggedIn;
  final String? searchKey;

  UserModel({
    required this.uid,
    required this.mosqueImage,
    required this.name,
    required this.email,
    required this.fcmToken,
    required this.mosqueID,
    required this.mosqueAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.postsCount,
    required this.role,
    required this.isLoggedIn,
    this.searchKey,
  });

  UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
    : uid = snapshot.id,
      mosqueImage = snapshot['mosqueImage'] ?? "",
      name = snapshot['name'] ?? "",
      email = snapshot['email'] ?? "",
      mosqueID = snapshot['mosqueID'] ?? "",
      mosqueAddress = snapshot['mosqueAddress'] ?? "",
      fcmToken = snapshot['fcmToken'] ?? "",
      isLoggedIn = snapshot['isLoggedIn'] ?? false,
      role = UserRole.values.byName(snapshot['role'] ?? UserRole.member.name),
      createdAt = snapshot['createdAt']?.toDate() ?? DateTime.now(),
      updatedAt = snapshot['updatedAt']?.toDate() ?? DateTime.now(),
      postsCount = snapshot['postsCount'] ?? 0,
      searchKey = snapshot['searchKey'] ?? "";

  Map<String, dynamic> toJson() => {
    "mosqueImage": mosqueImage,
    "name": name,
    "isLoggedIn": isLoggedIn,
    "email": email,
    "mosqueID": mosqueID,
    "mosqueAddress": mosqueAddress,
    "createdAt": createdAt,
    "fcmToken": fcmToken,
    "updatedAt": updatedAt,
    "postsCount": postsCount,
    "role": role.name,
    "searchKey": name.toLowerCase().trim(),
  };
}

enum UserRole { mosque, member }
