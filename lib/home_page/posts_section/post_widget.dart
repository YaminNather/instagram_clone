import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/models.dart';
import 'package:instagram_ui_clone/widgets/icon_toggle_button_widget.dart';



class WPost extends StatefulWidget {
  const WPost({Key? key, required this.post }) : super(key: key);

  @override
  _WPostState createState() => _WPostState();


  final Post post;
}

class _WPostState extends State<WPost> {
  @override
  Widget build(BuildContext context) {
    final Post post = widget.post;
    final String? location = post.location;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildUpperSection(),

        _buildImage(),

        _buildActionButtons(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildLikes(),

              const SizedBox(height: 4.0),

              _buildReply()
            ]
          )
        )
      ]
    );
  }

  Widget _buildImage() {
    return SizedBox(height: 300.0, child: Image.network(widget.post.imageURL, fit: BoxFit.cover));
  }

  Widget _buildUpperSection() {
    final Post post = widget.post;
    final String? location = post.location;

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(foregroundImage: new NetworkImage(post.postedUser.dpURL)),
          
          const SizedBox(width: 8.0),

          Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(post.postedUser.name),

              if(location != null) new Text(location)
            ]
          )
        ]
      )
    );
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
      children: <Widget>[
        CircleAvatar(
          maxRadius: 8.0, foregroundImage: new NetworkImage(widget.post.reply.user.dpURL)
        ),

        const SizedBox(width: 4.0),

        Text("Liked by ${widget.post.reply.user.name} and ${widget.post.likes - 1} others"),
      ]
    );
  }

  Widget _buildReply() => Text("${widget.post.reply.user.name} ${widget.post.reply.message}");
}