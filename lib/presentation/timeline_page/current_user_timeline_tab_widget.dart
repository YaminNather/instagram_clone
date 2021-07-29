import 'package:flutter/material.dart';
import '../models.dart';

class WCurrentUserTimelineTab extends StatefulWidget {
  const WCurrentUserTimelineTab({ Key? key }) : super(key: key);

  @override
  _WCurrentUserTimelineTabState createState() => _WCurrentUserTimelineTabState();
}

class _WCurrentUserTimelineTabState extends State<WCurrentUserTimelineTab> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text("Follow Requests", style: theme.textTheme.headline6),
          ),

          _buildEvents()
        ]
      ),
    );
  }

  Widget _buildEvents() {
    final List<_Event> newEvents = events.where((event) => event.timeSince.inMinutes < 60 * 2).toList();
    final List<_Event> todaysEvents = events.where(
      (event) => event.timeSince.inMinutes >= 60 * 2 && event.timeSince.inHours < 24
    ).toList();
    final List<_Event> thisWeeksEvents = events.where(
      (event) => event.timeSince.inHours >= 24 && event.timeSince.inDays < 4
    ).toList();
    final List<_Event> remainingEvents = events.where((event) => event.timeSince.inDays >= 4).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildEventsWithin("New", newEvents),

        _buildEventsWithin("Today", todaysEvents),

        _buildEventsWithin("This Week", thisWeeksEvents),

        _buildEventsWithin("This Month", remainingEvents),        
      ]
    );
  }

  Widget _buildEventsWithin(final String heading, final List<_Event> events) {
    final ThemeData theme = Theme.of(context);
    
    return Column(
      children: <Widget>[
        const Divider(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(heading),
              ),

              const SizedBox(height: 32.0),

              for(_Event event in events) _buildEvent(event)
            ]
          )
        )
      ]
    );
  }

  Widget _buildEvent(final _Event event) {
    Widget title;
    final Widget leading;
    final Widget trailing;

    const double trailingImageSize = 50.0;

    if(event is _LikedPostEvent) {
      String titleMsg = event.likedBy[0].name;      
      if(event.likedBy.length > 1)
        titleMsg += ", ${event.likedBy[1].name}";
      if(event.likedBy.length > 2)
        titleMsg += ", ${event.likedBy[2].name}";
      if(event.likedBy.length > 3)
        titleMsg += " and ${event.likedBy.length - 3} others";
      titleMsg += " liked your post.";

      title = _buildEventTitle(titleMsg, _getTimeSinceAsString(event.timeSince));

      leading = CircleAvatar(foregroundImage: NetworkImage(event.likedBy[0].dpURL));

      trailing = SizedBox(
        height: trailingImageSize, width: trailingImageSize, 
        child: Image.network(event.post.imageURL, fit: BoxFit.cover)
      );
    }

    else if(event is _FollowingEvent) {
      final String message = "${event.followedBy.name} started following you.";
      title = _buildEventTitle(message, _getTimeSinceAsString(event.timeSince));

      leading = CircleAvatar(foregroundImage: NetworkImage(event.followedBy.dpURL));

      trailing = ElevatedButton(child: const Text("Follow"), onPressed: () {});
    }

    else if(event is _MentionedInPostEvent) {
      final String message = "${event.mentionedBy.name} mentioned you in a comment:\n${event.message}";
      title = _buildEventTitle(message, _getTimeSinceAsString(event.timeSince));

      leading = CircleAvatar(foregroundImage: NetworkImage(event.mentionedBy.dpURL));
      trailing = SizedBox(
        height: trailingImageSize, width: trailingImageSize, 
        child: Image.network(event.post.imageURL, fit: BoxFit.cover)
      );
    }
    
    else
      throw new Error();        

    return ListTile(title: title, leading: leading, trailing: trailing);        
  }

  Widget _buildEventTitle(final String message, final String timeSince) {
    return Text.rich(
      TextSpan(
        text: message,
        children: <InlineSpan>[
          TextSpan(text: " $timeSince", style: const TextStyle(color: Colors.grey))
        ]
      )
    );
  }

  String _getTimeSinceAsString(final Duration timeSince) {
    if(timeSince.inHours <= 24)
      return " ${timeSince.inHours}h";

    return " ${timeSince.inDays}d";
  }
}


abstract class _Event {
  const _Event(this.timeSince);

  
  final Duration timeSince;
}

class _LikedPostEvent extends _Event {
  const _LikedPostEvent(this.post, this.likedBy, Duration timeSince) : super(timeSince);


  final Post post;
  final List<User> likedBy;
} 

class _FollowingEvent extends _Event {
  const _FollowingEvent(this.followedBy, Duration timeSince): super(timeSince);


  final User followedBy;
}

class _MentionedInPostEvent extends _Event {
  const _MentionedInPostEvent(this.mentionedBy, this.post, this.message, timeSince) : super(timeSince);


  final User mentionedBy;
  final Post post;
  final String message;
}


List<_Event> events = <_Event>[
  new _LikedPostEvent(posts[0], <User>[users[0]], const Duration(hours: 1, minutes: 30)),
  new _LikedPostEvent(posts[0], <User>[users[6], users[3]], const Duration(hours: 4)),
  new _MentionedInPostEvent(users[3], posts[3], "exactly what I was thinking!", const Duration(days: 2)),
  new _FollowingEvent(users[1], const Duration(days: 3)),
  new _FollowingEvent(users[5], const Duration(days: 3)),
  new _FollowingEvent(users[2], const Duration(days: 3)),
  new _FollowingEvent(users[7], const Duration(days: 4))
];