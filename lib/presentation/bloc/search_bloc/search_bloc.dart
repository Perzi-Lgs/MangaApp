import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/usecases.dart';

import '../../../domain/entities/MangaInfo.dart';
import '../../../domain/usecases/delete_search_in_history.dart';
import '../../../domain/usecases/get_research_manga copy.dart';
import '../../../domain/usecases/get_research_manga.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetResearchScans getResearchScans;
  final GetResearchHistory getResearchHistory;
  final DeleteSearchInHistory deleteSearchInHistory;

  SearchBloc(
      {required this.deleteSearchInHistory,
      required this.getResearchHistory,
      required this.getResearchScans})
      : super(SearchState()) {
    on<Research>(_onResearch);
    on<GetHistory>(_onGetHistory);
    on<DeleteHistory>(_onDeleteHistory);
  }

  void _onResearch(Research event, Emitter<SearchState> emit) async {
    try {
      emit(state.copyWith(status: SearchStatus.loading));

      final result =
          await getResearchScans(Params(query: event.keyword, page: 1));

      result.fold((l) => emit(state.copyWith(status: SearchStatus.failure)),
          (r) => emit(state.copyWith(status: SearchStatus.success, infos: r)));
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.failure));
    }
  }

  void _onGetHistory(GetHistory event, Emitter<SearchState> emit) async {
    try {
      emit(state.copyWith(status: SearchStatus.loading));

      final result = await getResearchHistory(NoParams());

      result.fold(
          (l) => emit(state.copyWith(status: SearchStatus.failure)),
          (r) => emit(state
              .copyWith(status: SearchStatus.success, history: r, infos: [])));
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.failure));
    }
  }

  void _onDeleteHistory(DeleteHistory event, Emitter<SearchState> emit) async {
    try {
      final result = await deleteSearchInHistory(
          DeleteSearchInHistoryParams(query: event.query));

      result.fold(
          (l) => emit(state.copyWith(status: SearchStatus.failure)),
          (r) =>
              emit(state.copyWith(status: SearchStatus.success, history: r)));
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.failure));
    }
  }
}
