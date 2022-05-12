part of 'download_bloc.dart';

enum DownloadStatus { initial, loading, success, error }

class DownloadState extends Equatable {
  DownloadState({this.status = DownloadStatus.initial, List<MangaInfo>? mangas})
      : mangas = mangas ?? [];

  final DownloadStatus status;
  final List<MangaInfo> mangas;

  DownloadState copyWith({DownloadStatus? status, List<MangaInfo>? mangas}) {
    return DownloadState(
        status: status ?? this.status, mangas: mangas ?? this.mangas);
  }

  @override
  List<Object> get props => [status, mangas];
}
