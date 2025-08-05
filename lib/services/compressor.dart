import 'dart:async';
import 'package:video_compress/video_compress.dart';

class FileCompressor {
  static Future<MediaInfo?> compressVideoWithProgress({
    required String filePath,
    required Function(double progress) onProgress,
  }) async {
    Subscription? subscription;

    try {
      // Subscribe to progress updates
      subscription = VideoCompress.compressProgress$.subscribe((progress) {
        onProgress(progress); // progress is a double (0 to 100)
      });

      // Start compressing the video
      final compressedVideo = await VideoCompress.compressVideo(
        filePath,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
      );

      subscription.unsubscribe(); // Clean up subscription
      return compressedVideo;
    } catch (e) {
      print("Compression error: $e");
      if (subscription != null) {
        subscription.unsubscribe();
      }
      return null;
    }
  }
}
