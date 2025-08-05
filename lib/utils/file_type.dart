class FileTypeUtils {
  static bool isDocument(String fileName) {
    if (fileName.isEmpty) return false;

    final extension = fileName.toLowerCase().split('.').last;
    final documentExtensions = [
      'pdf',
      'doc',
      'docx',
      'txt',
      'rtf',
      'odt',
      'pages',
      'xls',
      'xlsx',
      'csv',
      'ods',
      'numbers',
      'ppt',
      'pptx',
      'odp',
      'keynote',
      'zip',
      'rar',
      '7z',
      'tar',
      'gz'
    ];

    return documentExtensions.contains(extension);
  }

  static bool isImage(String fileName) {
    if (fileName.isEmpty) return false;

    final extension = fileName.toLowerCase().split('.').last;
    final imageExtensions = [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'bmp',
      'webp',
      'svg',
      'tiff',
      'tif',
      'ico',
      'heic',
      'heif'
    ];

    return imageExtensions.contains(extension);
  }

  static bool isVideo(String fileName) {
    if (fileName.isEmpty) return false;

    final extension = fileName.toLowerCase().split('.').last;
    final videoExtensions = [
      'mp4',
      'avi',
      'mov',
      'wmv',
      'flv',
      'webm',
      'mkv',
      'm4v',
      '3gp',
      'ogv',
      'ts',
      'mts',
      'm2ts'
    ];

    return videoExtensions.contains(extension);
  }

  static bool isAudio(String fileName) {
    if (fileName.isEmpty) return false;

    final extension = fileName.toLowerCase().split('.').last;
    final audioExtensions = [
      'mp3',
      'wav',
      'aac',
      'flac',
      'ogg',
      'wma',
      'm4a',
      'opus',
      'amr',
      'aiff',
      'pcm'
    ];

    return audioExtensions.contains(extension);
  }

  static String getFileExtension(String fileName) {
    if (fileName.isEmpty) return '';
    final parts = fileName.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : '';
  }

  static String getFileType(String fileName) {
    if (isImage(fileName)) return 'image';
    if (isVideo(fileName)) return 'video';
    if (isAudio(fileName)) return 'audio';
    if (isDocument(fileName)) return 'document';
    return 'unknown';
  }
}
