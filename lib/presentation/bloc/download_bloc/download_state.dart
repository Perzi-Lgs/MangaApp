part of 'download_bloc.dart';

enum DownloadStatus { initial, loading, success, error }

class DownloadState extends Equatable {
  DownloadState({
    this.status = DownloadStatus.initial,
    this.progress = 0});

  final DownloadStatus status;
  final double progress;

  DownloadState copyWith({DownloadStatus? status, double? progress}) {
    return DownloadState(
        status: status ?? this.status, progress: progress ?? this.progress);
  }

  @override
  List<Object> get props => [status, progress];
}
