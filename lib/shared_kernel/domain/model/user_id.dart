import 'package:instagram_ui_clone/domain_base/value_object.dart';

class UserId extends ValueObject<UserId> {
  const UserId(this.value);
  
  @override  
  List<Object?> get props => [];

  final String value;
}