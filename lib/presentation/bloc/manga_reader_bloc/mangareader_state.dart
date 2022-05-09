part of 'mangareader_bloc.dart';

enum MangareaderStateStatus { initial, loading, success, failure }

class MangareaderState extends Equatable {
  MangareaderState(
      {this.status = MangareaderStateStatus.initial, List<ScanImage>? images})
      : images = images ?? [];

  final MangareaderStateStatus status;
  final List<ScanImage> images;

  MangareaderState copyWith(
      {MangareaderStateStatus? status, List<ScanImage>? images}) {
    return MangareaderState(
        images: images ?? this.images, status: status ?? this.status);
  }


  @override
  List<Object> get props => [images, status];
}
