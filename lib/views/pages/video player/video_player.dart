import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key, required this.videoUrl});
  final String videoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: BetterPlayer.network(
          videoUrl,
          betterPlayerConfiguration: const BetterPlayerConfiguration(
            aspectRatio: 16 / 9,
            fit: BoxFit.contain,
            autoPlay: true,
            looping: false,
            fullScreenByDefault: true,
            showPlaceholderUntilPlay: true,
            autoDetectFullscreenDeviceOrientation: true,
            deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
            systemOverlaysAfterFullScreen: SystemUiOverlay.values,
            expandToFill: false,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              enableFullscreen: true,
              enablePlayPause: true,
              enableProgressBar: true,
              enableProgressText: true,
              enableSkips: true,
              enablePlaybackSpeed: true,
              enableQualities: true,
              enableOverflowMenu: true,
              showControlsOnInitialize: true,
              playerTheme: BetterPlayerTheme.material,
            ),
          ),
        ),
      ),
    );
  }
}
