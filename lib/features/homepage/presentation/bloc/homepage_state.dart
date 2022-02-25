part of 'homepage_bloc.dart';

enum HomepageStatus { initial, loading, success, failure }

extension HomepageStatusX on HomepageStatus {
  bool get isInitial => this == HomepageStatus.initial;
  bool get isLoading => this == HomepageStatus.loading;
  bool get isSuccess => this == HomepageStatus.success;
  bool get isFailure => this == HomepageStatus.failure;
}

class HomepageState extends Equatable {
  HomepageState({
    this.status = HomepageStatus.initial,
    List<MangaInfo>? infos,
  }) : infos = infos ?? [];
  
  final HomepageStatus status;
  final List<MangaInfo> infos;

  HomepageState copyWith({HomepageStatus? status, List<MangaInfo>? infos}) {
    return HomepageState(infos: infos ?? this.infos, status: status?? this.status);
  }

  @override
  List<Object> get props => [status, infos];
}