// ignore_for_file: body_might_complete_normally_nullable, unused_local_variable

import 'dart:io';

import 'package:cloudinary/cloudinary.dart';

class CloudinaryService {
  static Future<String?> uploadFile(String path) async {
    // final fileName = basename(path);
    final fileName = path.split("/").last;
    //we have to add file/ before the path to make the path useable
    final destination = 'files/$fileName';
    //Here the img will be uploaded on firestore storage
    final cloudinary = Cloudinary.signedConfig(
      apiKey: "238668356717384",
      apiSecret: "Bj2c70IEF9P5HhoqGp90paoSqew",
      cloudName: "dxulwbuyk",
    );

    final response = await cloudinary.upload(
      file: path,
      fileBytes: File(path).readAsBytesSync(),
      resourceType: CloudinaryResourceType.auto,
      folder: "timly",
      fileName: fileName,
      progressCallback: (count, total) {
        //print('Uploading image from file with progress: $count/$total');
      },
    );
    if (response.isSuccessful) {
      //print('Get your image from with ${response.secureUrl}');
      return response.secureUrl!;
    }
  }
}
