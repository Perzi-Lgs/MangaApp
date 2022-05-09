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

class GetHistory extends SearchEvent {
  const GetHistory();
}

class DeleteHistory extends SearchEvent {
  final String query;

  DeleteHistory({required this.query});

  @override
  List<Object> get props => [query];
}
