import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import "package:flutter/material.dart";
import 'package:instagram_ui_clone/presentation/app_widget/app_widget.dart';
import '../app_widget/theme_changer_provider_widget.dart';
import '../widgets/instagram_logo_widget.dart';

class WAuthPage extends StatelessWidget {
  const WAuthPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));

  AppBar _buildAppBar(final BuildContext context) {
    final AppController appController = WAppControllerProvider.of(context).appController;

    return AppBar(
      actions: const <Widget>[
        WChangeThemeButton()
      ]
    );
  }

  Widget _buildBody(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      alignment: Alignment.center,
      child: Column(        
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildLogo(context),          

          const SizedBox(height: 70.0),

          _buildSignInButton(context),

          const SizedBox(height: 50.0),

          _buildSignUpButton(context)          
        ]
      )
    );   
  }

  Widget _buildLogo(final BuildContext context) {  
    return const Padding( 
      padding: const EdgeInsets.all(64.0), 
      child: WInstagramLogo()
    );
  }

  Widget _buildSignInButton(final BuildContext context) {
    void onPressedCallback() => Navigator.pushNamed( context, "Sign In Page");

    return SizedBox(
      height: _buttonHeight, 
      child: ElevatedButton(
        child: const Text("Log in"), onPressed: onPressedCallback
      )
    );
  }

  Widget _buildSignUpButton(final BuildContext context) {
    void onPressedCallback() => Navigator.pushNamed(context, "Sign Up Page");
    
    return SizedBox(
      height: _buttonHeight, 
      child: OutlinedButton(child: const Text("Sign up"), onPressed: onPressedCallback)
    );
  }  



  static const double _buttonHeight = 50.0;
}

class WChangeThemeButton extends StatefulWidget {
  const WChangeThemeButton({ Key? key }) : super(key: key);

  @override
  _WChangeThemeButtonState createState() => _WChangeThemeButtonState();
}

class _WChangeThemeButtonState extends State<WChangeThemeButton> {
  @override
  Widget build(BuildContext context) {
    final AppController appController = WAppControllerProvider.of(context).appController;
    final IconData iconData = (!appController.isDark()) ? EvaIcons.sunOutline : EvaIcons.moonOutline;
      
    return IconButton(
      icon: Icon(iconData),
      onPressed: () {
        appController.changeTheme(isDark);
        
        setState(() => isDark = !isDark);
      }
    );
  }

 
  bool isDark = false;
}