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
      String sourceName) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MangaInfo>> getRandomScan() {
    throw UnimplementedError();
  }
}
