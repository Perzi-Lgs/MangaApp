part of 'download_bloc.dart';

enum DownloadStatus { initial, loading, success, error }

class DownloadState extends Equatable {
  DownloadState(
      {this.status = DownloadStatus.initial,
      this.progress = 0,
      List<String>? downloadedMangas,
      List<String>? downloadedChapterList,
      List<Uint8List>? chapterDataList})
      : downloadedMangas =
            downloadedMangas ?? List<String>.empty(growable: true),
        chapterDataList =
            chapterDataList ?? List<Uint8List>.empty(growable: true),
        downloadedChapterList =
            downloadedChapterList ?? List<String>.empty(growable: true);

  final DownloadStatus status;
  final double progress;
  final List<String> downloadedMangas;
  final List<String> downloadedChapterList;
  final List<Uint8List> chapterDataList;

  DownloadState copyWith(
      {DownloadStatus? status,
      double? progress,
      List<String>? downloadedChapterList,
      List<String>? downloadedMangas,
      List<Uint8List>? chapterDataList}) {
    return DownloadState(
        status: status ?? this.status,
        progress: progress ?? this.progress,
        downloadedMangas: downloadedMangas ?? this.downloadedMangas,
        downloadedChapterList:
            downloadedChapterList ?? this.downloadedChapterList,
        chapterDataList:
            chapterDataList ?? this.chapterDataList);
  }

  @override
  List<Object> get props => [status, progress];
}
