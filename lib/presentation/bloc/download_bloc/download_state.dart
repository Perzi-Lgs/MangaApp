part of 'download_bloc.dart';

enum DownloadStatus { initial, loading, success, error }

class DownloadState extends Equatable {
  DownloadState({this.status = DownloadStatus.initial, List<MangaInfo>? mangas})
      : mangas = mangas ?? [];

  final DownloadStatus status;
  final List<MangaInfo> mangas;

  @override
  List<Object> get props => [status, mangas];
}
