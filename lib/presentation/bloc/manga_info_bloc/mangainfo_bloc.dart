import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/get_manga_full_info.dart';
import '../../../domain/entities/CompleteMangaInfo.dart';

part 'mangainfo_event.dart';
part 'mangainfo_state.dart';

class MangainfoBloc extends Bloc<MangainfoEvent, MangainfoState> {
  GetFullMangaInfo getFullMangaInfo;

  MangainfoBloc({required this.getFullMangaInfo}) : super(MangainfoState()) {
    on<FetchMangaInfo>(_onFetchMangaData);
  }

  void _onFetchMangaData(
      FetchMangaInfo event, Emitter<MangainfoState> emit) async {
    try {
      emit(state.copyWith(status: MangainfoStateStatus.loading));

      final mangaInfo = await getFullMangaInfo(Params(url: event.url));
      print(mangaInfo);
      mangaInfo.fold(
          (l) => emit(state.copyWith(status: MangainfoStateStatus.failure)),
          (r) => emit(
              state.copyWith(status: MangainfoStateStatus.success, info: r)));
    } catch (e) {
      emit(state.copyWith(status: MangainfoStateStatus.failure));
    }
  }
}
