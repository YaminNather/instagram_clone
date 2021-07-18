import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/global_provider.dart';
import 'package:instagram_ui_clone/models.dart';
import 'package:instagram_ui_clone/widgets/gradient_ring_widget.dart';
import 'posts_section/posts_section_widget.dart';

part "stories_section/stories_section_widget.dart";

class WHomePage extends StatefulWidget {
  const WHomePage({ Key? key }) : super(key: key);

  @override
  _WHomePageState createState() => _WHomePageState();
}

class _WHomePageState extends State<WHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    final String logoURL = GlobalProvider.of(context).logoURLSmall;

    return AppBar(
      leading: IconButton(icon: const Icon(EvaIcons.cameraOutline), onPressed: () {}), 
      title: SizedBox(
        width: double.infinity,
        child: FractionallySizedBox(
          widthFactor: 0.5, alignment: Alignment.center, child: Image.network(logoURL)
        )
      ),
      actions: <Widget>[
        IconButton(icon: const Icon(EvaIcons.tvOutline), onPressed: () {}),
        
        _buildDMPageButton()
      ],
    );
  }

  Widget _buildDMPageButton() {
    void onPressedCallback() => Navigator.pushNamed(context, "DM Page");

    return IconButton(icon: const Icon(EvaIcons.paperPlaneOutline), onPressed: onPressedCallback);    
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          const WStoriesSection(),

          WPostsSection()
        ]
      ),
    );
  }  
}