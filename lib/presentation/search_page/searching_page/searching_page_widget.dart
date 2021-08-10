import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ui_clone/presentation/search_page/searching_page/bloc/searching_page_bloc.dart';
import 'package:instagram_ui_clone/presentation/widgets/search_bar_widget.dart';
import 'package:instagram_ui_clone/profile/profile.dart';

class WSearchingPage extends StatefulWidget {
  const WSearchingPage({ Key? key }) : super(key: key);

  @override
  _WSearchingPageState createState() => _WSearchingPageState();
}

class _WSearchingPageState extends State<WSearchingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchingPageBloc>(
      create: (context) => _bloc..add(const WidgetLoadedEvent()),
      child: SafeArea(child: Scaffold(appBar: _buildAppBar(), body: _buildBody()))
    );
  }
  
  AppBar _buildAppBar() {
    return AppBar(
      title: SizedBox(
        height: kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: WSearchBar(
            controller: _bloc.searchBarController,
            onChanged: (_) => _bloc.add(const ChangedSearchValueEvent()),
            onSubmitted: (value) => _bloc.add(const UpdateListEvent())
          )
        )
      )
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SearchingPageBloc, SearchingPageState>(
      builder: (context, state) {            
        if(_bloc.state.loading)
          return const Center(child: CircularProgressIndicator.adaptive());               

        if(_bloc.searchBarController.text.isNotEmpty && _bloc.state.foundProfiles.isEmpty) 
          return _buildMessage("No users found.");           

        return _buildFoundUserList();
      },
    );
  }

  Widget _buildFoundUserList() {
    return ListView.builder(
      itemCount: _bloc.state.foundProfiles.length,
      itemBuilder: (context, index) {
        final ProfileDTO profile = _bloc.state.foundProfiles[index];

        return ListTile(
          leading: _buildDP(profile.dpURL),
          title: Text(profile.username),
          onTap: () => _bloc.add(new ClickedProfileEvent(profile, context))
        );
      }
    );
  }

  Widget _buildDP(final String dpURL) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(512.0)
      ),
      padding: const EdgeInsets.all(2.0),
      child: CircleAvatar(foregroundImage: new NetworkImage(dpURL))
    );
  }

  Widget _buildMessage(final String message) {
    final ThemeData theme = Theme.of(context);

    return new Column(        
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 32.0),

        Center(child: Text(message, style: theme.textTheme.headline6))
      ]
    );
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }


  final SearchingPageBloc _bloc = new SearchingPageBloc();
}