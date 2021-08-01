import 'package:flutter/material.dart';

class WStateIndicatorIcon extends StatefulWidget {
  const WStateIndicatorIcon({ Key? key, required this.controller }) : super(key: key);

  @override
  _WAnimatedIconState createState() => _WAnimatedIconState();


  final StateIndicatorIconController controller;
}

class _WAnimatedIconState extends State<WStateIndicatorIcon> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onControllerEvent);
  }

  @override
  Widget build(BuildContext context) {
    final StateIndicatorIconController controller = widget.controller;

    final double opacity;
    if(controller._animationState == _AnimationState.fadingIn)
      opacity = 1.0;
    else
      opacity = 0.0;

    return TweenAnimationBuilder<double>(
      tween: new Tween(begin: 0, end: opacity), duration: const Duration(milliseconds: 200),
      onEnd: () {
        if(controller._animationState == _AnimationState.fadingIn)
          controller._fadeOut();              
      },
      builder: (context, t, child) {
        return Opacity(opacity: t, child: child);
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: FittedBox(
          fit: BoxFit.cover,
          child: Icon((controller.playing) ? Icons.play_arrow : Icons.pause, color: Colors.grey)
        ),
      )
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerEvent);
    widget.controller.dispose();

    super.dispose();
  }

  void _onControllerEvent() => setState(() {});  
}



class StateIndicatorIconController extends ChangeNotifier {
  void startAnimation(bool playing) {
    this.playing = playing;
    _fadeIn();
  }

  void _fadeIn() {
    _setAnimationState(_AnimationState.fadingIn);

    notifyListeners();
  }

  void _fadeOut() {
    _setAnimationState(_AnimationState.fadingOut);
  }  

  void _setAnimationState(final _AnimationState value) {
    _animationState = value;

    notifyListeners();
  } 



  bool playing = true;
  _AnimationState _animationState = _AnimationState.fadingIn;
}

enum _AnimationState { fadingIn, fadingOut }