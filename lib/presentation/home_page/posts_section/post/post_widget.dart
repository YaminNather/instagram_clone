import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/post/post.dart';
import 'package:instagram_ui_clone/presentation/home_page/posts_section/post/video_player/video_player_widget.dart';
import 'package:video_player/video_player.dart';
import '../../../../post/post_dto.dart';
import '../../../widgets/icon_toggle_button_widget.dart';



class WPost extends StatefulWidget {
  const WPost({required Key key, required this.post }) : super(key: key);

  @override
  _WPostState createState() => _WPostState();


  final PostDTO post;
}

class _WPostState extends State<WPost> {
  @override
  void initState() {
    super.initState();

    if(widget.post.mediaType == const VideoMediaType())
      _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final VideoPlayerController videoPlayerController = new VideoPlayerController.network(widget.post.imageURI);
    _videoPlayerController = videoPlayerController;

    await videoPlayerController.initialize();

    if(mounted)
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildUpperSection(),

        _buildMedia(),

        _buildActionButtons(),        

        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 2.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildCaption(),

              const SizedBox(height: 4.0),
            
              _buildLikes(),

              const SizedBox(height: 4.0),

              _buildReply(),

              const SizedBox(height: 4.0),

              _buildTimeSincePost()
            ]
          )
        )
      ]
    );
  }

  Widget _buildCaption() {
    return Text.rich(
      TextSpan(
        text: widget.post.userData.username, 
        style: const TextStyle(fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(text: " ${widget.post.caption}", style: const TextStyle(fontWeight: FontWeight.normal))
        ]
      )
    );
  }

  Widget _buildUpperSection() {
    final PostDTO post = widget.post;    

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(foregroundImage: new NetworkImage(post.userData.dpURL)),
          
          const SizedBox(width: 8.0),

          Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(post.userData.username)
            ]
          )
        ]
      )
    );
  }

  Widget _buildMedia() {
    final Widget media;
    if(widget.post.mediaType == const ImageMediaType())    
      media = Image.network(widget.post.imageURI, fit: BoxFit.cover);
    else {
      media = WVideoPlayer(url: widget.post.imageURI);
    }

    return SizedBox(height: 300.0, child: media);
  }

  Widget _buildActionButtons() {
    void likeButtonOnChangedCallback(bool value) {
      final Text content = Text(value ? "Liked post" : "Remove like from post");
      final SnackBar snackBar = SnackBar(content: content, duration: const Duration(seconds: 1));
      
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WIconToggleButton(          
          enabledIcon: const Icon(EvaIcons.heart, color: Colors.red), 
          disabledIcon: const Icon(EvaIcons.heartOutline),
          onChanged: likeButtonOnChangedCallback
        ),

        IconButton(icon: const Icon(EvaIcons.messageCircleOutline), onPressed: () {}),

        IconButton(icon: const Icon(EvaIcons.paperPlaneOutline), onPressed: () {})
      ]
    );
  }

  Widget _buildLikes() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        const CircleAvatar(radius: 8.0),

        const SizedBox(width: 4.0),

        const Text("Liked by LikedUser and 20 others"),
      ]
    );
  }

  Widget _buildReply() => const Text("ReplyingUser The reply");

  Widget _buildTimeSincePost() {
    return Text(
      timeSincePostAsString(widget.post.dateTime), 
      style: const TextStyle(color: Colors.grey)
    );
  }

  @override
  void dispose() {
    final VideoPlayerController? videoPlayerController = _videoPlayerController;
    if(videoPlayerController != null)
      videoPlayerController.dispose();

    super.dispose();
  }

  
  VideoPlayerController? _videoPlayerController;
}


String timeSincePostAsString(final DateTime postedTime) {
  final DateTime now = DateTime.now();

  final Duration timeSincePost = now.difference(postedTime);

  if(timeSincePost < const Duration(hours: 1))
    return "${timeSincePost.inMinutes} mins ago";

  if(timeSincePost < const Duration(days: 1))
    return "${timeSincePost.inHours} hours ago";

  if(timeSincePost < const Duration(days: 30))
    return "${timeSincePost.inDays} days ago";

  return "${timeSincePost.inDays ~/ 30} months ago";
}