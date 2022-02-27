import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/MangaInfo.dart';

abstract class HomePageRepository {
  Future<Either<Failure, List<MangaInfo>>> getHomepageScans(String route);

  Future<Either<Failure, List<MangaInfo>>> getListMangaPerSource(
      String sourceName);
}
