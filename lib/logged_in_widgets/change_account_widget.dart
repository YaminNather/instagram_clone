import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class WChangeAccount extends StatefulWidget {
  const WChangeAccount({ Key? key, this.locked = false }) : super(key: key);

  @override
  _WChangeAccountState createState() => _WChangeAccountState();


  final bool locked;
}

class _WChangeAccountState extends State<WChangeAccount> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,          
      children: <Widget>[
        if(widget.locked) const Icon(EvaIcons.lock, size: 16.0),

        const Text("jacob_w"),

        const Icon(EvaIcons.chevronDownOutline)
      ]
    );
  }
}