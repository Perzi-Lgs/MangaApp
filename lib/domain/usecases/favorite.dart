import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../entities/manga_info.dart';
import '../repositories/favorite_repository.dart';

class SwitchFavorite extends UseCase<bool, SwitchFavoriteParams> {
  final FavoriteRepository repository;

  SwitchFavorite(this.repository);

  @override
  Future<Either<Failure, bool>> call(SwitchFavoriteParams? params) async {
    return await repository.switchFavorite(params!.data);
  }
}

class SwitchFavoriteParams extends Equatable {
  final MangaInfo data;

  SwitchFavoriteParams({required this.data});

  @override
  List<Object?> get props => [data];
}

class GetIsFavorite extends UseCase<bool, GetIsFavoriteParams> {
  final FavoriteRepository repository;

  GetIsFavorite(this.repository);

  @override
  Future<Either<Failure, bool>> call(GetIsFavoriteParams? params) async {
    return await repository.getIsFavorite(params!.data);
  }
}

class GetIsFavoriteParams extends Equatable {
  final MangaInfo data;

  GetIsFavoriteParams({required this.data});

  @override
  List<Object?> get props => [data];
}

class GetAllFavorite extends UseCase<List<MangaInfo>, NoParams> {
  final FavoriteRepository repository;

  GetAllFavorite(this.repository);

  @override
  Future<Either<Failure, List<MangaInfo>>> call(NoParams? params) async {
    return await repository.getFavoriteList();
  }
}
