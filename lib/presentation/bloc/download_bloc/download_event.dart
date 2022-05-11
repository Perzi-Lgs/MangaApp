part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable {
  const DownloadEvent();

  @override
  List<Object> get props => [];
}

class GetDownloadedMangaInfos extends DownloadEvent {
  const GetDownloadedMangaInfos();

  @override
  List<Object> get props => [];
}

class GetDownloadedChaptersList extends DownloadEvent {
  const GetDownloadedChaptersList({required this.url});

  final String url;

  @override
  List<Object> get props => [];
}

// class GetDownloadChapter extends Equatable {
//   const GetDownloadChaptersList({required this.mangaUrl});

//   final String mangaUrl;

//   @override
//   List<Object> get props => [];
// }
