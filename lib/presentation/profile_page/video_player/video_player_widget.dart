import 'package:flutter/widgets.dart';
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

    _controller.initialize().then(
      (_) {
        if(mounted)
          setState(() {});
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    if(!_controller.value.isInitialized)
      return Container();    

    return VideoPlayer(_controller);
  }  



  late VideoPlayerController _controller;
}