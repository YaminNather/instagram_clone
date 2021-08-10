import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_ui_clone/post/likes.dart';
import 'package:instagram_ui_clone/post/post.dart';
import 'package:instagram_ui_clone/post/post_dto.dart';

void main() {
  group("operator ==", () {
    test("if all values of posts are same, then return true", () {
      final PostDTO post0 = new PostDTO(
        "PostId0", 
        const UserData("UserId0", "Username0", "DPURL0"),
        const ImageMediaType(),
        "ImageURL0",
        "Caption0",
        DateTime(2020),
        new Likes(const <String>["UserId1", "UserId2"])
      );

      final PostDTO post1 = new PostDTO(
        "PostId0",
        const UserData("UserId0", "Username0", "DPURL0"),
        const ImageMediaType(),
        "ImageURL0",
        "Caption0",
        DateTime(2020),
        new Likes(const <String>["UserId1", "UserId2"])
      );

      expect(post0 == post1, true);
    });

    test("if all values of posts are same, then return true", () {
      final PostDTO post0 = new PostDTO(
        "PostId0", 
        const UserData("UserId0", "Username0", "DPURL0"),
        const ImageMediaType(),
        "ImageURL0",
        "Caption0",
        DateTime(2020),
        new Likes(const <String>["UserId1", "UserId2"])
      );

      final PostDTO post1 = new PostDTO(
        "PostId1",
        const UserData("UserId0", "Username0", "DPURL0"),
        const ImageMediaType(),
        "ImageURL0",
        "Caption0",
        DateTime(2020),
        new Likes(const <String>["UserId1", "UserId2"])
      );

      expect(post0 != post1, true);
    });
  });
}