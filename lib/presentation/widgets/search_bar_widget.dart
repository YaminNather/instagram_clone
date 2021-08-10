import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class WSearchBar extends StatelessWidget {
  const WSearchBar({ Key? key, this.controller, this.onChanged, this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: getInputDecoration(),
      textAlignVertical: TextAlignVertical.center,
      controller: controller, onChanged: onChanged,
      onSubmitted: onSubmitted,
      autofocus: true
    );
  }

  InputDecoration getInputDecoration() {
    final OutlineInputBorder border = new OutlineInputBorder(
      borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.0)
    );

    return InputDecoration(        
      hintText: "Search", prefixIcon: const Icon(EvaIcons.searchOutline), border: border, 
      enabledBorder: border, focusedBorder: border, disabledBorder: border, errorBorder: border, 
      isCollapsed: true
    );
  }


  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
}