part of 'searching_page_bloc.dart';

class SearchingPageState extends Equatable {
  const SearchingPageState(this.foundProfiles, this.loading);

  factory SearchingPageState.initial() {
    return SearchingPageState(new BuiltList<ProfileDTO>(), false);
  }

  SearchingPageState copyWith({BuiltList<ProfileDTO>? foundProfiles, bool? loading}) {
    return new SearchingPageState(foundProfiles ?? this.foundProfiles, loading ?? this.loading);
  }

  @override
  List<Object> get props => [...foundProfiles, loading];


  final BuiltList<ProfileDTO> foundProfiles;
  final bool loading;
}

