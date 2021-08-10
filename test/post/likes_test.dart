import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_ui_clone/post/likes.dart';

void main() {
  group("operator==", () {
    test('if has same userIds then returns true', () {
      final Likes likes0 = new Likes(const <String>["UserId0", "UserId1"]);
      final Likes likes1 = new Likes(const <String>["UserId0", "UserId1"]);

      expect(likes0 == likes1, true);
    });

    test('if has different userIds then returns false', () {
      final Likes likes0 = new Likes(const <String>["UserId0", "UserId1"]);
      final Likes likes1 = new Likes(const <String>["UserId0", "UserId2"]);

      expect(likes0 != likes1, true);
    });

    test('if has same userIds in different order, then returns false', () {
      final Likes likes0 = new Likes(const <String>["UserId0", "UserId1"]);
      final Likes likes1 = new Likes(const <String>["UserId1", "UserId0"]);

      expect(likes0 != likes1, true);
    });
  });
}