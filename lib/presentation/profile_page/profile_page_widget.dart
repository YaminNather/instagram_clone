import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ui_clone/injector.dart';
import 'package:instagram_ui_clone/post/post.dart';
import 'package:instagram_ui_clone/presentation/profile_page/video_player/video_player_widget.dart';
import 'bloc/profile_page_bloc.dart';
import '../logged_in_widgets/change_account_widget.dart';

class WProfilePage extends StatefulWidget {
  const WProfilePage({ Key? key }) : super(key: key);

  @override
  _WProfilePageState createState() => _WProfilePageState();
}

class _WProfilePageState extends State<WProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfilePageBloc>(
      create: (context) => bloc..add(const WidgetLoadedEvent()),
      child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
        builder: (context, state) {
          if(state is LoadingState)
            return const Center(child: const CircularProgressIndicator.adaptive());

          return Scaffold(appBar: _buildAppBar(), body: _buildBody());
        },
      )
    );
  }

  AppBar _buildAppBar() {
    final LoadedState loadedState = bloc.state as LoadedState;

    return AppBar(
      centerTitle: true, automaticallyImplyLeading: false, 
      title: new WChangeAccount(locked: true, name: loadedState.profile.username),
      actions: <Widget>[
        IconButton(
          icon: const Icon(EvaIcons.personRemoveOutline), 
          onPressed: () => bloc.add(new ClickedSignOutButtonEvent(context))
        )
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildDP(),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: _buildStats()
                    )
                  )
                ]
              ),

              const SizedBox(height: 16.0),

              _buildBio(),

              const SizedBox(height: 16.0),

              _buildEditProfileButton()              
            ]
          )
        ),
        
        const SizedBox(height: 16.0),

        Expanded(child: _buildPosts())
      ]
    );
  }

  Widget _buildEditProfileButton() {
    void onPressedCallback() {
      bloc.add(new ClickedEditProfileButtonEvent(context));
    }

    return OutlinedButton(child: const Text("Edit Profile"), onPressed: onPressedCallback);
  }

  Row _buildStats() {
    final LoadedState loadedState = bloc.state as LoadedState;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildStat("Posts", loadedState.posts.length),

        _buildStat("Followers", loadedState.followersCount),

        _buildStat("Following", loadedState.followingCount)
      ]
    );
  }

  Widget _buildStat(final String statName, final int value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(value.toString(), style: Theme.of(context).textTheme.headline6),

        Text(statName)
      ]
    );
  }

  Widget _buildBio() {
    final LoadedState loadedState = bloc.state as LoadedState;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Text(loadedState.profile.username),

        new Text(loadedState.profile.bio)
      ]
    );
  }

  Widget _buildDP() {
    final LoadedState loadedState = bloc.state as LoadedState;

    return Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.grey, width: 2.0),
        borderRadius: new BorderRadius.circular(1000.0)
      ),
      padding: const EdgeInsets.all(4.0), 
      child: CircleAvatar(maxRadius: 40.0, foregroundImage: NetworkImage(loadedState.profile.dpURL))
    );
  }

  Widget _buildPosts() {
    final LoadedState loadedState = bloc.state as LoadedState;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),      
      itemCount: loadedState.posts.length, 
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          // child: new Container()
          child: _buildMedia(loadedState.posts[index])
        );
      }
    );
  }

  Widget _buildMedia(final ProfilePagePost post) {
    if(post.mediaType == const VideoMediaType())
      return WVideoPlayer(url: post.uri);
    else
      return Image.network(post.uri, fit: BoxFit.cover);
  }

  @override
  void dispose() {
    bloc.dispose();

    super.dispose();
  }




  final ProfilePageBloc bloc = getIt<ProfilePageBloc>();
}