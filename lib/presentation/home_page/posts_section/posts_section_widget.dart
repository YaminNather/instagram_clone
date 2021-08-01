import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_page_bloc.dart';
import 'post/post_widget.dart';

class WPostsSection extends StatefulWidget {
  const WPostsSection({ Key? key }) : super(key: key);

  @override
  _WPostsSectionState createState() => _WPostsSectionState();
}

class _WPostsSectionState extends State<WPostsSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if(state is LoadingState)
          return const Center(child: const CircularProgressIndicator.adaptive());

        final LoadedState loadedState = state as LoadedState;
        final Posts posts = loadedState.posts;

        final List<Widget> children = <Widget>[];
        for(int i = 0; i < loadedState.posts.getLength(); i++) 
          children.add(WPost(key: new Key(posts[i].postId), post: posts[i]));

        return Column(
          mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children
        );
      }
    );
  }
}
