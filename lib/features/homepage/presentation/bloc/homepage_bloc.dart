import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/usecases.dart';
import 'package:mobile/features/homepage/domain/entities/MangaInfo.dart';
import 'package:mobile/features/homepage/domain/usecases/get_list_manga_per_sources.dart';
import 'package:mobile/features/homepage/domain/usecases/get_homepage_scans.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  // final GetListMangaPerSource getListMangaPerSource;
  final GetHomepageScans getHomepageScans;
  
  HomepageBloc({required this.getHomepageScans}) : super(HomepageState()) {
    on<FetchHomeMangaPage>(_onFetchManga);
    // on<RefetchHomeMangaPage>(_onRefetchManga);
  }

  void _onFetchManga(FetchHomeMangaPage event, Emitter<HomepageState> emit) async {
    print('object');
    try {
      emit(state.copyWith(status: HomepageStatus.loading));

      final scansHomePage = await getHomepageScans(NoParams());
      scansHomePage.fold((l) => emit(state.copyWith(status: HomepageStatus.failure)), (r) => emit(state.copyWith(status: HomepageStatus.success, infos: r)));
      print('arg');
    } catch (e) {
      emit(state.copyWith(status: HomepageStatus.failure));
    }
  }

  // void _onRefetchManga(RefetchHomeMangaPage event, Emitter<HomepageState> emit) async {
  //   if (!state.status.isSuccess) return;
  //   if (state.infos == List.empty()) return;

  //   try {
  //     final scansHomePage = await getHomepageScans(NoParams());
  //     scansHomePage.fold(
  //         (l) => emit(state.copyWith(status: HomepageStatus.failure)),
  //         (r) =>
  //             emit(state.copyWith(status: HomepageStatus.success, infos: r)));
  //   } on Exception {
  //     emit(state);
  //   }
  // }
}
