import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ui_clone/presentation/auth_page/auth_page_widget.dart';
import 'package:instagram_ui_clone/presentation/opening_page_decider_widget/bloc/opening_page_decider_bloc.dart';
import 'package:instagram_ui_clone/presentation/signed_in_page/signed_in_page_widget.dart';

class WOpeningPageDecider extends StatefulWidget {
  const WOpeningPageDecider({ Key? key }) : super(key: key);

  @override
  State<WOpeningPageDecider> createState() => new _WOpeningPageDeciderState();
}

class _WOpeningPageDeciderState extends State<WOpeningPageDecider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OpeningPageDeciderBloc>(
      create: (_) => _bloc..add(new WidgetLoadedEvent(context)),
      child: _buildBody()
    );    
  }

  Widget _buildBody() {
    return BlocBuilder<OpeningPageDeciderBloc, OpeningPageDeciderState>(
      builder: (context, state) {
        if(state is LoadingState)
          return const Center(child: Text("Checking signed in status"));

        final LoadedState loadedState = state as LoadedState;
        if(loadedState.signedIn == false)
          return const WAuthPage();
        else
          return const WSignedInPage();        
      }
    );
  }


  final OpeningPageDeciderBloc _bloc = new OpeningPageDeciderBloc();
}