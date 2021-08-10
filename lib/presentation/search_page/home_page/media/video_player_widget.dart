import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WVideoPlayer extends StatefulWidget {
  const WVideoPlayer({ Key? key, required this.url }) : super(key: key);

  @override
  _WVideoPlayerState createState() => _WVideoPlayerState();


  final String url;
}

class _WVideoPlayerState extends State<WVideoPlayer> {
  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.url);
    _controller.initialize().then( (_) async => setState(() {}) );
  }

  @override
  Widget build(BuildContext context) {        
    return GestureDetector(
      onTap: () async {

        if(!_controller.value.isInitialized)
          return;
        
        print("CustomLog: Clicked");
        if(_controller.value.isPlaying)
          await _controller.pause();
        else
          await _controller.play();
      },
      child: Stack(
        children: <Widget>[
          VideoPlayer(_controller),

          const Positioned(top: 8.0, right: 8.0, child: Icon(EvaIcons.videoOutline, color: Colors.grey))
        ],
      )
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }


  late VideoPlayerController _controller; 
}