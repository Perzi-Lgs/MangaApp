import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/homepage/domain/entities/MangaInfo.dart';
import 'package:mobile/features/homepage/domain/usecases/get_homepage_scans.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final GetHomepageScans getHomepageScans;

  HomepageBloc({required this.getHomepageScans}) : super(HomepageState()) {
    on<FetchHomeMangaPage>(_onFetchManga);
    on<RefetchHomeMangaPage>(_onRefetchManga);
    on<ChangeTabMangaPage>(_onChangeTab);
    on<LoadMorePage>(_loadMorePage);
  }

  void _onFetchManga(
      FetchHomeMangaPage event, Emitter<HomepageState> emit) async {
    try {
      emit(state.copyWith(status: HomepageStatus.loading));

      final scansHomePage =
          await getHomepageScans(Params(route: _tabsConverter(state.tab)));
      scansHomePage.fold(
          (l) => emit(state.copyWith(status: HomepageStatus.failure)),
          (r) =>
              emit(state.copyWith(status: HomepageStatus.success, infos: r)));
    } catch (e) {
      emit(state.copyWith(status: HomepageStatus.failure));
    }
  }

  void _onRefetchManga(
      RefetchHomeMangaPage event, Emitter<HomepageState> emit) async {
    if (!state.status.isSuccess) return;
    if (state.infos == List.empty()) return;

    try {
      final scansHomePage =
          await getHomepageScans(Params(route: _tabsConverter(state.tab)));
      scansHomePage.fold(
          (l) => emit(state.copyWith(status: HomepageStatus.failure)),
          (r) =>
              emit(state.copyWith(status: HomepageStatus.success, infos: r)));
    } on Exception {
      emit(state);
    }
  }

  void _onChangeTab(
      ChangeTabMangaPage event, Emitter<HomepageState> emit) async {
    emit(state.copyWith(tab: event.tab));
    try {
      emit(state.copyWith(status: HomepageStatus.loading));

      final scansHomePage =
          await getHomepageScans(Params(route: _tabsConverter(event.tab)));
      scansHomePage.fold(
          (l) => emit(state.copyWith(status: HomepageStatus.failure)),
          (r) =>
              emit(state.copyWith(status: HomepageStatus.success, infos: r)));
    } on Exception {
      emit(state.copyWith(status: HomepageStatus.failure));
    }
  }

  void _loadMorePage(LoadMorePage event, Emitter<HomepageState> emit) async {
    emit(state.copyWith(status: HomepageStatus.loading));
    for (var i = state.page + 1; i <= state.page + event.numberPage; i++) {
      print(state.page);
      print(event.numberPage);
      final scansHomePage = await getHomepageScans(
          Params(route: _tabsConverter(state.tab), page: i));
      scansHomePage.fold(
          (l) => emit(state.copyWith(status: HomepageStatus.failure)),
          (r) => state.infos.addAll(r));
    }
    print(state.infos.length);
    emit(state.copyWith(
        page: state.page + event.numberPage, status: HomepageStatus.success));
  }

  String _tabsConverter(HomepageTab tab) {
    switch (tab) {
      case HomepageTab.home:
        return tab.getHome;
      case HomepageTab.hot:
        return tab.getHot;
      case HomepageTab.lastUpadted:
        return tab.getLastUpdated;
      case HomepageTab.newest:
        return tab.getNewest;
      default:
        return tab.getHome;
    }
  }
}
