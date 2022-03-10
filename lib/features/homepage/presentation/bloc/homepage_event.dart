part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class FetchHomeMangaPage extends HomepageEvent {
  const FetchHomeMangaPage();

  @override
  List<Object> get props => [];
}

class RefetchHomeMangaPage extends HomepageEvent {
  const RefetchHomeMangaPage();

  @override
  List<Object> get props => [];
}

class ChangeTabMangaPage extends HomepageEvent {
  const ChangeTabMangaPage({required this.tab});

  final HomepageTab tab;

  @override
  List<Object> get props => [tab];
}

class LoadMorePage extends HomepageEvent {
  const LoadMorePage({this.numberPage = 1});

  final int numberPage;

  @override
  List<Object> get props => [numberPage];
}
