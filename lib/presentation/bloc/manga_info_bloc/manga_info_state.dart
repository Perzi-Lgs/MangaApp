part of 'manga_info_bloc.dart';

enum MangaInfoStateStatus { initial, loading, success, failure }
class MangaInfoState extends Equatable {
  MangaInfoState({this.status = MangaInfoStateStatus.initial, CompleteMangaInfo ?info}) : info = info ?? CompleteMangaInfo.empty;
  
  final MangaInfoStateStatus status;
  final CompleteMangaInfo info;

  MangaInfoState copyWith(
      {MangaInfoStateStatus? status, CompleteMangaInfo? info}) {
    return MangaInfoState(
        info: info ?? this.info, status: status ?? this.status);
  }

  @override
  List<Object> get props => [status, info];

}
