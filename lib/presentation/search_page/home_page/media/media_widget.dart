import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/post/post.dart';
import 'package:instagram_ui_clone/presentation/search_page/home_page/media/video_player_widget.dart';

class WMedia extends StatefulWidget {
  const WMedia({ Key? key, required this.type, required this.url}) : super(key: key);

  @override
  _WMediaState createState() => _WMediaState();


  final MediaType type;
  final String url;
}

class _WMediaState extends State<WMedia> {
  @override
  Widget build(BuildContext context) {
    if(widget.type == const ImageMediaType())
      return Image.network(widget.url, fit: BoxFit.cover);
    else
      return WVideoPlayer(url: widget.url);
  }
}