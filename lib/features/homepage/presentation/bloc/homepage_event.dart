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
