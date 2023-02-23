part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable {
  const DownloadEvent();

  @override
  List<Object> get props => [];
}

class GetDownloadedMangaList extends DownloadEvent {
  const GetDownloadedMangaList();

  @override
  List<Object> get props => [];
}

class GetDownloadedChaptersList extends DownloadEvent {
  const GetDownloadedChaptersList({required this.name});

  final String name;

  @override
  List<Object> get props => [];
}

class LaunchChaptersDownload extends DownloadEvent {
  const LaunchChaptersDownload({required this.info, required this.chapters});

  final MangaInfo info;
  final List<Chapter> chapters;

  @override
  List<Object> get props => [];
}

class GetDownloadedChaptersData extends DownloadEvent {
  const GetDownloadedChaptersData({required this.chapter, required this.mangaName});

  final String chapter;
  final String mangaName;

  @override
  List<Object> get props => [];
}
