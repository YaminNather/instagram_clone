import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/presentation/search_page/searching_page/searching_page_widget.dart';
import "home_page/home_page_widget.dart";

class WSearchPage extends StatefulWidget {
  const WSearchPage({ Key? key }) : super(key: key);

  @override
  _WSearchPageState createState() => _WSearchPageState();
}

class _WSearchPageState extends State<WSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        onGenerateRoute: (setting) {
          final Widget page;
          if(setting.name == "Home Page")
            page = const WHomePage();
          else if(setting.name == "Searching Page")
            page = const WSearchingPage();          
          else
            page = const WHomePage();

          return new MaterialPageRoute(builder: (_) => page);
        },
        initialRoute: "Home Page"
      )
    );
  }
}