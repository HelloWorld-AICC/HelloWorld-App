import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../design_system/hello_colors.dart';
import 'full_screen_video_player.dart';

class VideoPreview extends StatefulWidget {
  final String videoUrl;

  const VideoPreview({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showFullScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPlayer(videoUrl: widget.videoUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFullScreen(context), // Handle tap for full screen
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : const Center(
              child: CircularProgressIndicator(
                  color: HelloColors.mainBlue, strokeWidth: 2)),
    );
  }
}
