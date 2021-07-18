import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/logged_in_widgets/change_account_widget.dart';
import 'package:instagram_ui_clone/models.dart';
import 'package:instagram_ui_clone/widgets/search_bar_widget.dart';

class WDMPage extends StatefulWidget {
  const WDMPage({ Key? key }) : super(key: key);

  @override
  _WDMPageState createState() => _WDMPageState();
}

class _WDMPageState extends State<WDMPage> {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: _buildAppBar(), body: _buildBody());

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true, title: const WChangeAccount(),
      actions: [ IconButton(icon: const Icon(EvaIcons.plus ), onPressed: () {}) ]
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const WSearchBar(),

            for(int i = 0; i < latestReplies.length; i++) _buildListItem(latestReplies[i])
          ]
        ),
      ),
    );
  }

  Widget _buildListItem(final LatestReply latestReply) {
    final int timeSinceInSeconds = latestReply.timeSince.inSeconds;

    final String timeSince;
    if(timeSinceInSeconds < 60)
      timeSince = "now";
    else
      timeSince = "${timeSinceInSeconds ~/ 60} m";

    return new ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
      leading: CircleAvatar(maxRadius: 32.0, foregroundImage: NetworkImage(latestReply.user.dpURL)), 
      title: Text(latestReply.user.name), 
      subtitle: Row(        
        children: <Widget>[
          Expanded(child: Text(latestReply.message, overflow: TextOverflow.ellipsis)),

          const SizedBox(width: 8.0),

          Text(timeSince)
        ],
      ),
      // trailing: const Icon(EvaIcons.cameraOutline)
    );
  }
}

List<LatestReply> latestReplies = <LatestReply>[
  new LatestReply(users[0], "Have a nice day, bro!", const Duration(seconds: 60)),
  new LatestReply(
    users[1], "I heard this is a good movie, wanna watch it together?", const Duration(seconds: 90)
  ),
  new LatestReply(
    users[2], "See you on the next meeting!", const Duration(seconds: 10)
  ),
  new LatestReply(users[3], "Sounds good lmao", const Duration(seconds: 60 * 3)),
  new LatestReply(
    users[4], "The new design looks good, but there are a few things we have to change.", 
    const Duration(seconds: 60 * 10)
  ),
  new LatestReply(users[5], "Thank you, bro!", const Duration(seconds: 60 * 5)),
  new LatestReply(users[6], "Yep, I'm going to travel to Indonesia tom.", const Duration(seconds: 60)),
  new LatestReply(users[7], "Instagram's UI is pretty good, ngl.", const Duration(seconds: 60 * 1)),
  new LatestReply(users[8], "Did you read this message?", const Duration(seconds: 60))
];

class LatestReply {
  const LatestReply(this.user, this.message, this.timeSince);


  final User user;
  final String message;
  final Duration timeSince;  
}