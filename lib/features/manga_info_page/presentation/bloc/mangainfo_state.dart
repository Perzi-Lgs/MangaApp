part of 'mangainfo_bloc.dart';

enum MangainfoStateStatus { initial, loading, success, failure }
class MangainfoState extends Equatable {
  MangainfoState({this.status = MangainfoStateStatus.initial, CompleteMangaInfo ?info}) : info = info ?? CompleteMangaInfo.empty;
  
  final MangainfoStateStatus status;
  final CompleteMangaInfo info;

  MangainfoState copyWith({MangainfoStateStatus? status, CompleteMangaInfo? info}) {
    return MangainfoState(info: info ?? this.info, status: status ?? this.status);
  }

  @override
  List<Object> get props => [status, info];

}
