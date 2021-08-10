import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/presentation/app_widget/themes.dart';
import 'package:instagram_ui_clone/presentation/app_widget/theme_changer_provider_widget.dart';
import 'package:instagram_ui_clone/presentation/change_password_page/change_password_page_widget.dart';
import 'package:instagram_ui_clone/presentation/edit_profile_page/edit_profile_page_widget.dart';
import 'package:instagram_ui_clone/presentation/opening_page_decider_widget/opening_page_decider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_page/auth_page_widget.dart';
import '../dm_page/dm_page_widget.dart';
import '../sign_in_page/sign_in_page.dart';
import '../sign_up_page/sign_up_page_widget.dart';
import '../signed_in_page/signed_in_page_widget.dart';
import 'firebase_initializer_widget.dart';

class WApp extends StatefulWidget {
  const WApp({ Key? key }) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => new _WAppState();
}

class _WAppState extends State<WApp> {
  @override
  void initState() {
    super.initState();

    _controller.addListener(rebuildWidget);
  }

  @override
  Widget build(BuildContext context) {
    return WAppControllerProvider(
      appController: _controller,
      child: MaterialApp(
        title: 'Flutter Demo', 
        theme: new Themes(_controller._isDark).getTheme(),
        routes: <String, Widget Function(BuildContext)>{
          "Authentication Page" : (_) => const WAuthPage(),
          "Sign Up Page" : (_) => const WSignUpPage(),
          "Sign In Page" : (_) => const WSignInPage(),
          "Signed In Page" : (_) => const WSignedInPage(),
          "DM Page" : (_) => const WDMPage(),
          "Edit Profile Page" : (_) => const WEditProfilePage(),
          "Change Password Page" : (_) => const WChangePasswordPage()
        },
        home: const WFirebaseInitializer(child: WOpeningPageDecider()),
        debugShowCheckedModeBanner: false
      ),
    );
  }

  void rebuildWidget() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(rebuildWidget);

    super.dispose();
  }


  final AppController _controller = new AppController();
}


class AppController extends ChangeNotifier {
  bool isDark() => _isDark;
  
  void changeTheme(final bool toDark) {
    _isDark = toDark;
            
    notifyListeners();
  }



  bool loading = true;
  bool _isDark = false;
}