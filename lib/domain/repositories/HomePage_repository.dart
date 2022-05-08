import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/manga_info.dart';

abstract class HomePageRepository {
  Future<Either<Failure, List<MangaInfo>>> getHomepageScans(String route, int page);

  Future<Either<Failure, List<MangaInfo>>> getListMangaPerSource(
      String sourceName);
}
