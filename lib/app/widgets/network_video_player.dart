import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NetworkVideoPlayer extends StatefulWidget {
  const NetworkVideoPlayer({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  final String videoUrl;

  @override
  State<NetworkVideoPlayer> createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  late VideoPlayerController controller;
  bool isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) {
        isControllerInitialized = true;
      });
  }

  @override
  void dispose() {
    isControllerInitialized = false;
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('myVideo${widget.videoUrl}'),
      onVisibilityChanged: (VisibilityInfo info) {
        // debugPrint("${info.visibleFraction} of my widget is visible");
        if (isControllerInitialized) {
          if (info.visibleFraction > 0.5) {
            controller.play();
          } else {
            controller.pause();
          }
        }
      },
      child: VideoPlayerWidget(controller: controller),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({Key? key, required this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) => controller.value.isInitialized
      ? VideoPlayer(controller)
      : const Center(child: CircularProgressIndicator());
}
