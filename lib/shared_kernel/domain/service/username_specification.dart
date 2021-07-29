import 'package:injectable/injectable.dart';

@singleton
class UsernameSpecification {
  bool isValid(final String username) {
    return username.length >= 5;
  }
}