import 'package:dartz/dartz.dart';
import 'package:mobile/domain/repositories/bookmark_repository.dart';

import '../../core/errors/failures.dart';
import '../data_sources/bookmark_local_data_source.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkLocalDataSource localDataSource;

  BookmarkRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, String>> getLastRead(String mangaName) async {
    try {
      final res = localDataSource.getLastRead(mangaName);
      return Right(res);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> setLastRead(
      String lastChapterRead, String mangaName) async {
    try {
      final bool reslr =
          await localDataSource.setLastRead(mangaName, lastChapterRead);
      await localDataSource.setAllRead(mangaName, lastChapterRead);
      return Right(reslr);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllRead(String mangaName) async {
    try {
      return Right(localDataSource.getAllRead(mangaName));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
