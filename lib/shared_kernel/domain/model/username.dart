import 'package:injectable/injectable.dart';
import '../service/username_specification.dart';
import '../../../domain_base/value_object.dart';

class Username extends ValueObject<Username>{
  const Username._(this.value);

  const Username.empty() : value = "";

  @override
  List<Object?> get props => [value];


  final String value;
}

@singleton
class UsernameFactory {
  const UsernameFactory(this.specification);

  Username create(final String value) {
    if(specification.isValid(value))
      throw new InvalidUsernameError();

    return new Username._(value);
  }



  final UsernameSpecification specification;
}

class InvalidUsernameError extends Error {}