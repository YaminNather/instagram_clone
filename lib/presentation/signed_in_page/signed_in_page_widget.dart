import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_ui_clone/presentation/search_page/search_page_widget.dart';
import '../add_post_page/add_post_page_widget.dart';
import '../home_page/home_page_widget.dart';
import '../profile_page/profile_page_widget.dart';
import '../timeline_page/timeline_page_widget.dart';
import 'dp_icon_widget.dart';

class WSignedInPage extends StatefulWidget {
  const WSignedInPage({ Key? key }) : super(key: key);

  @override
  _WSignedInPageState createState() => _WSignedInPageState();
}

class _WSignedInPageState extends State<WSignedInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar()
    );
  }

  Widget _buildBody() {
    final Map<int, Widget> tabMap = <int, Widget>{
      0 : const WHomePage(),
      1 : const WSearchPage(),
      2 : const WAddPostPage(),
      3 : const WTimelinePage(),
      4 : const WProfilePage()
    };

    return tabMap[currentTab] ?? tabMap[0]!;
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(      
      iconSize: 28.0,      
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: const Icon(EvaIcons.homeOutline), activeIcon: const Icon(EvaIcons.home), label: ""
        ),

        const BottomNavigationBarItem(
          icon: const Icon(EvaIcons.searchOutline), activeIcon: const Icon(EvaIcons.search), label: ""
        ),
        
        const BottomNavigationBarItem(
          icon: const Icon(EvaIcons.plusSquareOutline), activeIcon: const Icon(EvaIcons.plusSquare), 
          label : ""
        ),
        
        const BottomNavigationBarItem(
          icon: const Icon(EvaIcons.heartOutline), activeIcon: const Icon(EvaIcons.heart), label : ""
        ),

        BottomNavigationBarItem(
          icon: Container(
            decoration: new BoxDecoration(
              border: new Border.all(width: 1.0), borderRadius: new BorderRadius.circular(1000.0)
            ),
            padding: const EdgeInsets.all(1.0),
            child: const WDPIcon()
          ), 
          label : ""
        ),
      ],
      currentIndex: currentTab,
      onTap: _changeTab
    );
  }

  void  _changeTab(int index) => setState( () => currentTab = index );



  int currentTab = 0;
}