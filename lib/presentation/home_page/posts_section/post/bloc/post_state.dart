part of 'post_bloc.dart';

class PostState extends Equatable {
  const PostState(this.liked, this.tryingToLike);
  
  PostState copyWith({bool? liked, bool? tryingToLike}) {
    return new PostState(liked ?? this.liked, tryingToLike ?? this.tryingToLike);
  }

  @override
  List<Object?> get props => [liked, tryingToLike];



  final bool liked;
  final bool tryingToLike;
}