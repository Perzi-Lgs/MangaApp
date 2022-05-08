import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/get_manga_full_info.dart';
import '../../../domain/entities/CompleteMangaInfo.dart';

part 'manga_info_event.dart';
part 'manga_info_state.dart';

class MangaInfoBloc extends Bloc<MangainfoEvent, MangaInfoState> {
  GetFullMangaInfo getFullMangaInfo;

  MangaInfoBloc({required this.getFullMangaInfo}) : super(MangaInfoState()) {
    on<FetchMangaInfo>(_onFetchMangaData);
  }

  void _onFetchMangaData(
      FetchMangaInfo event, Emitter<MangaInfoState> emit) async {
    try {
      emit(state.copyWith(status: MangaInfoStateStatus.loading));

      final mangaInfo = await getFullMangaInfo(Params(url: event.url));
      print(mangaInfo);
      mangaInfo.fold(
          (l) => emit(state.copyWith(status: MangaInfoStateStatus.failure)),
          (r) => emit(
              state.copyWith(status: MangaInfoStateStatus.success, info: r)));
    } catch (e) {
      emit(state.copyWith(status: MangaInfoStateStatus.failure));
    }
  }
}
