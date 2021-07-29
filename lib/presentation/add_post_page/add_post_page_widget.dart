import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../injector.dart';
import '../../post/post.dart';

import 'bloc/add_post_page_bloc.dart';

class WAddPostPage extends StatefulWidget {
  const WAddPostPage({ Key? key }) : super(key: key);

  @override
  _WAddPostPageState createState() => _WAddPostPageState();
}

class _WAddPostPageState extends State<WAddPostPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocProvider<AddPostPageBloc>(
      create: (context) => _bloc,
      child: Scaffold(appBar: AppBar(title: const Text("Add Post")), body: _buildBody(theme))
    );
  }

  Widget _buildBody(final ThemeData theme) {
    return BlocBuilder<AddPostPageBloc, AddPostPageState>(
      builder: (context, state) {
        if(state is LoadingState)
          return const Center(child: const CircularProgressIndicator.adaptive());

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: _buildPost()),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildHeading("Video", theme),            

                  _buildVideoFromGalleryButton(),

                  _buildVideoFromCameraButton(),
                  
                  _buildHeading("Image", theme),

                  _buildImageFromGalleryButton(),
                  
                  _buildImageFromCameraButton(),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  ListTile _buildVideoFromCameraButton() {
    void onTapCallback() {
      _bloc.add(ClickedPickMediaButtonEvent(const VideoMediaType(), ImageSource.camera, context));
    }
    
    return ListTile(leading: const Icon(EvaIcons.camera), title: const Text("Camera"), onTap: onTapCallback);
  }

  ListTile _buildVideoFromGalleryButton() {
    void onTapCallback() {
      _bloc.add(ClickedPickMediaButtonEvent(const VideoMediaType(), ImageSource.gallery, context));
    }
    
    return ListTile(
      leading: const Icon(EvaIcons.fileAddOutline), title: const Text("Gallery"), onTap: onTapCallback
    );
  }

  ListTile _buildImageFromCameraButton() {
    void onTapCallback() {
      _bloc.add(ClickedPickMediaButtonEvent(const ImageMediaType(), ImageSource.camera, context));
    }
    
    return ListTile(leading: const Icon(EvaIcons.camera), title: const Text("Camera"), onTap: onTapCallback);
  }

  ListTile _buildImageFromGalleryButton() {
    void onTapCallback() {
      _bloc.add(ClickedPickMediaButtonEvent(const ImageMediaType(), ImageSource.gallery, context));
    }

    return ListTile(
      leading: const Icon(EvaIcons.fileAddOutline), title: const Text("Gallery"), onTap: onTapCallback
    );
  }

  Widget _buildPost() {
    return Container(height: 128 * 3.0, color: Colors.black);
  }

  Text _buildHeading(final String text, final ThemeData theme) {
    return Text(text, style: theme.textTheme.headline6);
  }


  final AddPostPageBloc _bloc = getIt<AddPostPageBloc>();
}