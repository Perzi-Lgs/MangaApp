import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/manga_info.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, bool>> switchFavorite(MangaInfo data);
  Future<Either<Failure, bool>> getIsFavorite(MangaInfo data);
  Future<Either<Failure, List<MangaInfo>>> getFavoriteList();
}
