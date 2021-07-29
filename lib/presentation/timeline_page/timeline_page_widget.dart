import 'package:flutter/material.dart';
import '../timeline_page/current_user_timeline_tab_widget.dart';

class WTimelinePage extends StatefulWidget {
  const WTimelinePage({ Key? key }) : super(key: key);

  @override
  _WTimelinePageState createState() => _WTimelinePageState();
}

class _WTimelinePageState extends State<WTimelinePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, initialIndex: 0, 
      child: Scaffold(appBar: _buildAppBar(), body: _buildBody())      
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const TabBar(
        tabs: const <Widget>[
          const Tab(text: "Following"),

          const Tab(text: "You")
        ]
      )
    );
  }

  Widget _buildBody() {
    return const TabBarView(
      children: const <Widget>[
        const WCurrentUserTimelineTab(),

        const WCurrentUserTimelineTab()
      ]
    );
  }
}