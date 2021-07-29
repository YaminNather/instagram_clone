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
      title: new WChangeAccount(locked: true, name: loadedState.username),
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

              _buildEditProfileButton(),
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
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(loadedState.posts.length.toString(), style: Theme.of(context).textTheme.headline6),

            const Text("Posts")
          ]
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("834", style: Theme.of(context).textTheme.headline6),

            const Text("Followers")
          ]
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("162", style: Theme.of(context).textTheme.headline6),

            const Text("Following")
          ]
        )
      ]
    );
  }

  Widget _buildBio() {
    final LoadedState loadedState = bloc.state as LoadedState;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Text(loadedState.username),

        new Text(loadedState.bio)
      ]
    );
  }

  Widget _buildDP() {
    final LoadedState loadedState = bloc.state as LoadedState;

    return Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.grey, width: 2.0),
        borderRadius: new BorderRadius.circular(1000.0),
      ),
      padding: const EdgeInsets.all(4.0), 
      child: CircleAvatar(
        maxRadius: 40.0, 
        foregroundImage: NetworkImage(loadedState.dpURL)
      )
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


  final ProfilePageBloc bloc = getIt<ProfilePageBloc>(); 

  // static const List<String> postURLs = const <String>[
  //   "https://expertphotography.com/wp-content/uploads/2020/07/candid-photography-3.jpg",
  //   "https://i.pinimg.com/564x/89/42/9f/89429fd25f6f7d18ad8f25516fd370f8.jpg",
  //   "https://3.imimg.com/data3/BM/AY/MY-14891732/friends-photography-500x500.png",
  //   "https://i.pinimg.com/564x/92/97/ff/9297ff54bd29634ac067ca4db4103647.jpg",
  //   "https://i.pinimg.com/564x/47/d6/1c/47d61c147ca821f1cd274f85f770a91f.jpg",
  //   "https://i.pinimg.com/236x/10/61/ef/1061ef96cac26d7c0c6f16b31d7cdc46.jpg",
  //   "https://i.pinimg.com/564x/6d/d2/bf/6dd2bf62c54918650d32c640c2977997.jpg",
  //   "https://i.pinimg.com/564x/0b/e9/67/0be9674d8d5fe067ac850901f587d323.jpg",
  //   "https://3.imimg.com/data3/TK/QI/MY-14896318/friends-photography-500x500.jpg",
  //   "https://i.pinimg.com/564x/f5/5c/1e/f55c1ea00ffcb51491870ae1c3621bff.jpg",
  //   "https://i.pinimg.com/564x/94/da/eb/94daeb169fa0732cbe0a67751214de6f.jpg"
  // ];
}