part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class Research extends SearchEvent {
  final String keyword;

  Research({required this.keyword});

  @override
  List<Object> get props => [keyword];
}
