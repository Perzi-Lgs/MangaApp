import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/domain/entities/manga_info.dart';

import '../../../core/usecases.dart';
import '../../../domain/usecases/favorite.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final SwitchFavorite switchFavoriteUsecase;
  final GetIsFavorite getIsFavoriteUsecase;
  final GetAllFavorite getAllFavoriteUsecase;

  FavoriteCubit(
      {required this.getAllFavoriteUsecase,
      required this.switchFavoriteUsecase,
      required this.getIsFavoriteUsecase})
      : super(FavoriteState(data: [], isFav: false));

  void switchFavorite(MangaInfo data) async {
    final res = await switchFavoriteUsecase(SwitchFavoriteParams(data: data));

    res.fold(
        (l) => emit(
            state.copyWith(status: FavoriteStateStatus.failure, isFav: false)),
        (r) => emit(
            state.copyWith(status: FavoriteStateStatus.success, isFav: r)));
  }

  void getIsFavorite(MangaInfo data) async {
    final res = await getIsFavoriteUsecase(GetIsFavoriteParams(data: data));

    res.fold(
        (l) => emit(
            state.copyWith(status: FavoriteStateStatus.failure, isFav: false)),
        (r) => emit(
            state.copyWith(status: FavoriteStateStatus.success, isFav: r)));
  }

  void getAllFavorite() async {
    final res = await getAllFavoriteUsecase(NoParams());

    print(res);
    res.fold(
      (l) => emit(state.copyWith(status: FavoriteStateStatus.failure)),
      (r) => emit(state.copyWith(status: FavoriteStateStatus.success, data: r)),
    );
  }
}

enum FavoriteStateStatus { initial, loading, success, failure }

class FavoriteState extends Equatable {
  final List<MangaInfo> data;
  final bool isFav;
  final FavoriteStateStatus status;

  const FavoriteState(
      {this.status = FavoriteStateStatus.initial,
      required this.data,
      required this.isFav});

  FavoriteState copyWith(
      {FavoriteStateStatus? status, List<MangaInfo>? data, bool? isFav}) {
    return FavoriteState(
        data: data ?? this.data,
        status: status ?? this.status,
        isFav: isFav ?? this.isFav);
  }

  @override
  List<Object> get props => [data, isFav, status];
}
