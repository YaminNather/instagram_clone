import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injector.dart';
import '../widgets/instagram_logo_widget.dart';
import '../models.dart';
import '../widgets/gradient_ring_widget.dart';
import 'bloc/home_page_bloc.dart';
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
    return BlocProvider<HomePageBloc>(
      create: (context) => _bloc..add(const WidgetLoadedEvent()),
      child: Scaffold(appBar: _buildAppBar(), body: _buildBody())
    );
  }

  AppBar _buildAppBar() {  
    return AppBar(
      leading: IconButton(icon: const Icon(EvaIcons.cameraOutline), onPressed: () {}), 
      title: const SizedBox(
        width: double.infinity,
        child: FractionallySizedBox(
          widthFactor: 0.5, alignment: Alignment.center, 
          child: WInstagramLogo()
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

          const WPostsSection()
        ]
      )
    );
  }  



  final HomePageBloc _bloc = getIt<HomePageBloc>();
}