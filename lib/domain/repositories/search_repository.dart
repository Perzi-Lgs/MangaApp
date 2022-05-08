import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/manga_info.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<MangaInfo>>> getSearchScans(
      String route, int page);

  Future<Either<Failure, List<String>>> deleteSearchInHistory(String query);
  Future<Either<Failure, List<String>>> getSearchHistory();
}
