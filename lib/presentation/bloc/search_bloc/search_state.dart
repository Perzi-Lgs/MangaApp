part of 'search_bloc.dart';

enum SearchStatus { initial, loading, success, failure }

extension SearchStatusX on SearchStatus {
  bool get isInitial => this == SearchStatus.initial;
  bool get isLoading => this == SearchStatus.loading;
  bool get isSuccess => this == SearchStatus.success;
  bool get isFailure => this == SearchStatus.failure;
}

class SearchState extends Equatable {
  SearchState(
      {this.status = SearchStatus.initial,
      this.page = 1,
      List<MangaInfo>? infos,
      List<String>? history})
      : infos = infos ?? [],
        history = history ?? [];

  final SearchStatus status;
  final List<MangaInfo> infos;
  final List<String> history;
  final int page;

  SearchState copyWith(
      {SearchStatus? status,
      List<MangaInfo>? infos,
      int? page,
      List<String>? history}) {
    return SearchState(
        infos: infos ?? this.infos,
        status: status ?? this.status,
        page: page ?? this.page,
        history: history ?? this.history);
  }

  @override
  List<Object> get props => [page, infos, status, history];
}
