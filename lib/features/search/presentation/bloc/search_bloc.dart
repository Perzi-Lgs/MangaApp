import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../homepage/domain/entities/MangaInfo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<Research>(_onResearch);
  }

  void _onResearch(Research event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: SearchStatus.loading));
    emit(state.copyWith(status: SearchStatus.success, infos: [
      MangaInfo(
          img: "https://avt.mkklcdnv6temp.com/19/v/1-1583464475.jpg",
          name: "Tales of Demons and Gods",
          url: "https://readmanganato.com/manga-ax951880")
    ]));
  }
}
