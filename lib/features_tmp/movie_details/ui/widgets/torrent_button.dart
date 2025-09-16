import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TorrentButton extends StatefulWidget {
  final String videoUrl;

  const TorrentButton({super.key, required this.videoUrl});

  @override
  State<TorrentButton> createState() => _TorrentButtonState();
}

class _TorrentButtonState extends State<TorrentButton> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // لو الرابط غلط أو مش من يوتيوب، هنا ناخد ID افتراضي
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? "dQw4w9WgXcQ";

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Now Playing"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
      ),
    );
  }
}