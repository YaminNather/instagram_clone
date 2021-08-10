import 'package:injectable/injectable.dart';

@lazySingleton
class UsernameSpecification {
  bool isValid(final String username) {
    return username.length >= 5;
  }
}