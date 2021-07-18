part of "../home_page_widget.dart";

class WStoriesSection extends StatefulWidget {
  const WStoriesSection({ Key? key }) : super(key: key);

  @override
  _WStoriesSectionState createState() => _WStoriesSectionState();
}

class _WStoriesSectionState extends State<WStoriesSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        height: 100.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal, itemCount: users.length, 
          itemBuilder: (context, index) => _buildStory(users[index])
        )
      ),
    );
  }

  Widget _buildStory(User user) {
    final Border outerBorder = new Border.all(color: Colors.pink, width: 4.0);
    final BorderRadius outerBorderRadius = new BorderRadius.circular(1000.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,      
        children: <Widget>[
          WGradientRing(
            padding: 2.0,
            width: 2.0,
            child: CircleAvatar(
              radius: 32.0, backgroundColor: Colors.pink[300], foregroundImage: NetworkImage(user.dpURL)
            ),
          ),

          const SizedBox(height: 4.0),

          Text(user.name)
        ]
      )
    );
  }  
}