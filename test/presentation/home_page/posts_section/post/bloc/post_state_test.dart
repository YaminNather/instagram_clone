import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_ui_clone/post/likes.dart';
import 'package:instagram_ui_clone/post/post.dart';
import 'package:instagram_ui_clone/presentation/home_page/bloc/home_page_bloc.dart';

void main() {
  group("operator==", () {
    test('if has same posts then returns true', () {
      final Posts posts0 = new Posts(
        <PostDTO>[
          new PostDTO(
            "PostId0", 
            const UserData("UserId0", "Username0", "DPURL0"),
            const ImageMediaType(),
            "ImageURL0",
            "Caption0",
            DateTime(2020),
            new Likes(const <String>["UserId1", "UserId2"])
          ),
          new PostDTO(
            "PostId1", 
            const UserData("UserId0", "Username0", "DPURL0"),
            const ImageMediaType(),
            "ImageURL0",
            "Caption0",
            DateTime(2020),
            new Likes(const <String>["UserId1", "UserId2"])
          )
        ]
      );
      final Posts posts1 = new Posts(
        <PostDTO>[
          new PostDTO(
            "PostId0", 
            const UserData("UserId0", "Username0", "DPURL0"),
            const ImageMediaType(),
            "ImageURL0",
            "Caption0",
            DateTime(2020),
            new Likes(const <String>["UserId1", "UserId2"])
          ),
          new PostDTO(
            "PostId1", 
            const UserData("UserId0", "Username0", "DPURL0"),
            const ImageMediaType(),
            "ImageURL0",
            "Caption0",
            DateTime(2020),
            new Likes(const <String>["UserId1", "UserId2"])
          )
        ]
      );

      expect(posts0 == posts1, true);
    });

    test('if has different posts then returns false', () {
      final Posts posts0 = new Posts(
        <PostDTO>[
          new PostDTO(
            "PostId0", 
            const UserData("UserId0", "Username0", "DPURL0"),
            const ImageMediaType(),
            "ImageURL0",
            "Caption0",
            DateTime(2020),
            new Likes(const <String>["UserId1", "UserId2"])
          ),
          new PostDTO(
            "PostId1", 
            const UserData("UserId0", "Username0", "DPURL0"),
            const ImageMediaType(),
            "ImageURL0",
            "Caption0",
            DateTime(2020),
            new Likes(const <String>["UserId1", "UserId2"])
          )
        ]
      );

      final Posts posts1 = new Posts(
        <PostDTO>[
          new PostDTO(
            "PostId0", 
            const UserData("UserId0", "Username0", "DPURL0"),
            const ImageMediaType(),
            "ImageURL0",
            "Caption0",
            DateTime(2020),
            new Likes(const <String>["UserId1", "UserId2"])
          ),
          new PostDTO(
            "PostId1", 
            const UserData("UserId0", "Username0", "DPURL0"),
            const ImageMediaType(),
            "ImageURL0",
            "Caption0",
            DateTime(2020),
            new Likes(const <String>["UserId2", "UserId3"])
          )
        ]
      );

      expect(posts0 != posts1, true);
    });
  });    
}