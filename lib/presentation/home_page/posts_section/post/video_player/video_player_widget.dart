import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/presentation/home_page/posts_section/post/video_player/state_indicator_icon_widget.dart';
import 'package:video_player/video_player.dart';

class WVideoPlayer extends StatefulWidget {
  const WVideoPlayer({ Key? key, required this.url}) : super(key: key);

  @override
  _WVideoPlayerState createState() => _WVideoPlayerState();

  
  final String url;
}

class _WVideoPlayerState extends State<WVideoPlayer> {
  @override
  void initState() {
    super.initState();
    
    _videoPlayerController = new VideoPlayerController.network(widget.url);

    _videoPlayerController.initialize().then(
      (_) {
        if(mounted)
          setState(() {});
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final VideoPlayerController controller = _videoPlayerController;
        
    if(!controller.value.isInitialized)
      return new Container();    

    void onTapCallback() async {
      if(controller.value.isPlaying)
        await controller.pause();
      else
        await controller.play();

      _stateIndicatorIconController.startAnimation(controller.value.isPlaying);
    }

    return GestureDetector(
      onTap: onTapCallback, 
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          VideoPlayer(controller),

          WStateIndicatorIcon(controller: _stateIndicatorIconController)
        ],
      )
    );
  }


  late VideoPlayerController _videoPlayerController;
  final StateIndicatorIconController _stateIndicatorIconController = new StateIndicatorIconController();
}