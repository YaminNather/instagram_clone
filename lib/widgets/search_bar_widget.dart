import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class WSearchBar extends StatelessWidget {
  const WSearchBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = new OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12.0)
    );

    return TextField( 
      decoration: InputDecoration(
        hintText: "Search", prefixIcon: const Icon(EvaIcons.searchOutline), border: border, 
        enabledBorder: border, focusedBorder: border, disabledBorder: border, errorBorder: border, 
        fillColor: Colors.grey[200]!, 
      ) 
    );
  }
}