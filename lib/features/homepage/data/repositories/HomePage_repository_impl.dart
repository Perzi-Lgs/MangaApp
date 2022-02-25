import 'package:mobile/constants/error_message_constant.dart';
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/core/network.dart';
import 'package:mobile/features/homepage/data/datasources/Homepage_remote_data_source.dart';
import 'package:mobile/features/homepage/domain/entities/MangaInfo.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/features/homepage/domain/repositories/HomePage_repository.dart';

class HomePageRepositoryImpl implements HomePageRepository {
  final HomepageRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const HomePageRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<MangaInfo>>> getListMangaPerSource(
      String sourceName) async {
    if (await networkInfo.isConnected) {
      try {
        final mangaList = await remoteDataSource.getListMangaInfoPerSource(sourceName);
        return Right(mangaList);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure(timeoutServerError));
    }
  }

  @override
  Future<Either<Failure, List<MangaInfo>>> getHomepageScans() async {
    if (await networkInfo.isConnected) {
      try {
        final randomManga = await remoteDataSource.getHomepageScans();
        return Right(randomManga);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure(timeoutServerError));
    }
  }
}
