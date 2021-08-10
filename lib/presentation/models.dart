class User {
  const User(this.name, this.dpURL);


  final String name;
  final String dpURL;
}

class Reply {
  const Reply(this.user, this.message);


  final User user;
  final String message;
}

class Post {
  const Post(this.postedUser, this.imageURL, this.likes, this.reply, {this.location});


  final User postedUser;
  final String imageURL;
  final String? location;
  final int likes;
  final Reply reply;
}

const List<User> users = const <User>[
  const User("joshua_l", "https://randomuser.me/api/portraits/men/86.jpg"), 
  const User("craig_love", "https://randomuser.me/api/portraits/men/91.jpg"), 
  const User("Sam_79", "https://randomuser.me/api/portraits/men/41.jpg"),
  const User("__Maveline__", "https://randomuser.me/api/portraits/women/29.jpg"), 
  const User("sunny9", "https://randomuser.me/api/portraits/women/77.jpg"),
  const User("youareme_x", "https://randomuser.me/api/portraits/women/69.jpg"),
  const User("world_blender", "https://randomuser.me/api/portraits/women/79.jpg"),
  const User("dumb_guy12", "https://randomuser.me/api/portraits/men/48.jpg"),
  const User("im_a_rainbox9847", "https://randomuser.me/api/portraits/women/19.jpg")

];


List<Post> posts = <Post>[
  new Post(
    users[0], "https://wallpaper.dog/large/20355892.jpg", 20, new Reply(users[4], "Wow space"), 
    location: "Tokyo, Japan"
  ),
  new Post(
    users[4], "https://wallpaper.dog/large/20355896.png", 42, new Reply(users[1], "Space looks cool")
  ),
  new Post(
    users[1], "https://wallpaperaccess.com/full/32465.jpg", 39, new Reply(users[2], "Omg its space!!"), 
    location: "Uganda"
  ),
  new Post(
    users[2], "https://wallpaperaccess.com/full/32452.jpg", 189, new Reply(users[0], "uWu Soo cutteee"), 
    location: "Andromeda"
  )
];