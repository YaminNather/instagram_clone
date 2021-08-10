part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
  
  @override
  List<Object> get props => [];
}

class LoadingState extends HomePageState {
  const LoadingState();
}

class LoadedState extends HomePageState {
  const LoadedState(this.posts);

  @override  
  List<Object> get props => [posts];



  final Posts posts;
}





class Posts extends Equatable {
  const Posts._(this.posts);  

  factory Posts(List<PostDTO> posts) {
    return new Posts._(new List<PostDTO>.from(posts));
  }
  
  int getLength() => posts.length;
  
  PostDTO operator[](index) => posts[index];  

  @override  
  List<Object?> get props => posts;



  final List<PostDTO> posts;
}