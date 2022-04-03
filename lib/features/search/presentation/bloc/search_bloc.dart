import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../homepage/domain/entities/MangaInfo.dart';
import '../../domain/usecases/get_research_manga.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetResearchScans getResearchScans;

  SearchBloc({required this.getResearchScans}) : super(SearchState()) {
    on<Research>(_onResearch);
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
}
