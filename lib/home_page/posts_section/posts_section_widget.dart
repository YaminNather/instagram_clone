import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/models.dart';
import 'post_widget.dart';

class WPostsSection extends StatefulWidget {
  const WPostsSection({ Key? key }) : super(key: key);

  @override
  _WPostsSectionState createState() => _WPostsSectionState();
}

class _WPostsSectionState extends State<WPostsSection> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    for(int i = 0; i < posts.length; i++) {
      children.add(WPost(post: posts[i]));
    }

    return Column(
      mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: children
    );
  }
}
