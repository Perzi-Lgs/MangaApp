part of 'mangareader_bloc.dart';

enum MangareaderStateStatus { initial, loading, success, failure }

class MangareaderState extends Equatable {
  MangareaderState(
      {this.status = MangareaderStateStatus.initial, List<ScanImage>? images, this.index = 0})
      : images = images ?? [];

  final MangareaderStateStatus status;
  final int index;
  final List<ScanImage> images;

  MangareaderState copyWith(
      {MangareaderStateStatus? status, List<ScanImage>? images, int? index}) {
    return MangareaderState(
        images: images ?? this.images, status: status ?? this.status, index: index ?? this.index);
  }


  @override
  List<Object> get props => [images, status, index];
}
