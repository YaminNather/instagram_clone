import 'package:equatable/equatable.dart';

class Likes extends Equatable {
  factory Likes(List<String> userIds) {
    return new Likes._(new List.from(userIds));
  }

  const Likes._(this._userIds);
  
  String operator[](int index) => _userIds[index];

  Likes add(String userId) {
    if(_userIds.contains(userId))
      throw new Error();

    return new Likes._(<String>[..._userIds, userId]);
  }

  Likes remove(String userId) {
    if(!_userIds.contains(userId))
      throw new Error();

    final List<String> newList = new List<String>.from(_userIds);
    newList.remove(userId);

    return new Likes._(newList);
  }

  bool contains(String userId) {
    return _userIds.contains(userId);
  }

  int get length => _userIds.length;

  @override
  List<Object> get props => _userIds;



  final List<String> _userIds;
}