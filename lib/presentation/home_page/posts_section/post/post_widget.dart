import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ui_clone/post/likes.dart';
import '../../../../injector.dart';
import '../../../../post/post.dart';
import 'video_player/video_player_widget.dart';
import '../../../../post/post_dto.dart';
import '../../../widgets/icon_toggle_button_widget.dart';
import 'bloc/post_bloc.dart';



class WPost extends StatefulWidget {
  const WPost({required Key key, required this.post }) : super(key: key);

  @override
  _WPostState createState() => _WPostState();


  final PostDTO post;
}

class _WPostState extends State<WPost> {  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => _bloc..add(new WidgetLoadedEvent(widget.post)),
      child: Column(
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
      )
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
    else
      media = WVideoPlayer(url: widget.post.imageURI);

    return SizedBox(height: 300.0, child: media);
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildLikeButton(),

        IconButton(icon: const Icon(EvaIcons.messageCircleOutline), onPressed: () {}),

        IconButton(icon: const Icon(EvaIcons.paperPlaneOutline), onPressed: () {})
      ]
    );
  }

  Widget _buildLikeButton() {
    void onChangedCallback(bool value) {
      _bloc.add(new ClickedLikeButtonEvent(context, widget.post));
    }

    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        // if(state.tryingToLike)
        //   return const CircularProgressIndicator.adaptive();

        return WIconToggleButton(
          enabledIcon: const Icon(EvaIcons.heart, color: Colors.red), 
          disabledIcon: const Icon(EvaIcons.heartOutline),
          onChanged: (!state.tryingToLike) ? onChangedCallback : null,
          value: _bloc.state.liked
        );
      }
    );
  }

  Widget _buildLikes() {
    final Likes likes = widget.post.likes;
    final String message;
    if(likes.length == 0)
      message = "No likes";
    else 
      message = "Liked by ${likes.length}";

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const CircleAvatar(radius: 8.0),

        const SizedBox(width: 4.0),

        Text(message)
      ]
    );
  }

  Widget _buildReply() => const Text("ReplyingUser The reply");

  Widget _buildTimeSincePost() {
    return Text(timeSincePostAsString(widget.post.dateTime), style: const TextStyle(color: Colors.grey));
  }

  

  final PostBloc _bloc = new PostBloc();
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