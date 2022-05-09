part of 'manga_info_bloc.dart';

abstract class MangainfoEvent extends Equatable {
  const MangainfoEvent();

  @override
  List<Object> get props => [];
}

class FetchMangaInfo extends MangainfoEvent {
  const FetchMangaInfo({required this.url});

  final String url;

  @override
  List<Object> get props => [url];
}
