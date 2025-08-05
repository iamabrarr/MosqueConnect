import 'dart:typed_data';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailService {
  static Future<Uint8List?> getThumbnailFromFile(String filePath) async {
    Uint8List? thumbnail = await VideoThumbnail.thumbnailData(
      video: filePath,
      timeMs: 1000,
    );
    return thumbnail;
  }

  static Future<Uint8List?> getThumbnailFromNetwork(String networkURL) async {
    Uint8List? thumbnail = await VideoThumbnail.thumbnailData(
      video: networkURL,
      timeMs: 1000,
    );
    return thumbnail;
  }
}
