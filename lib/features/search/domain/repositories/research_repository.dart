import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../homepage/domain/entities/MangaInfo.dart';

abstract class ResearchRepository {
  Future<Either<Failure, List<MangaInfo>>> getResearchScans(
      String route, int page);

  Future<Either<Failure, List<String>>> deleteSearchInHistory(String query);
  Future<Either<Failure, List<String>>> getSearchHistory();
}
