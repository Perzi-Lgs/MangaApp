part of 'homepage_bloc.dart';

enum HomepageStatus { initial, loading, success, failure }

enum HomepageTab { home, hot, lastUpadted, newest }

extension HomepageStatusX on HomepageStatus {
  bool get isInitial => this == HomepageStatus.initial;
  bool get isLoading => this == HomepageStatus.loading;
  bool get isSuccess => this == HomepageStatus.success;
  bool get isFailure => this == HomepageStatus.failure;
}

extension HomepageTabX on HomepageTab {
  bool get isHome => this == HomepageTab.home;
  bool get isHot => this == HomepageTab.hot;
  bool get isLastUpdated => this == HomepageTab.lastUpadted;
  bool get isNewest => this == HomepageTab.newest;
  String get getHome => 'home';
  String get getHot => 'hot';
  String get getLastUpdated => 'latest';
  String get getNewest => 'newest';
}

class HomepageState extends Equatable {
  HomepageState({
    this.tab = HomepageTab.home,
    this.status = HomepageStatus.initial,
    this.page = 1,
    List<MangaInfo>? infos,
  }) : infos = infos ?? [];

  final HomepageStatus status;
  final HomepageTab tab;
  final List<MangaInfo> infos;
  final int page;

  HomepageState copyWith(
      {HomepageStatus? status,
      HomepageTab? tab,
      List<MangaInfo>? infos,
      int? page}) {
    return HomepageState(
        infos: infos ?? this.infos,
        status: status ?? this.status,
        tab: tab ?? this.tab,
        page: page ?? this.page);
  }

  @override
  List<Object> get props => [tab, status, infos, page];
}
