import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../../../../domain/repositories/research_repository.dart';

class GetResearchHistory extends UseCase<List<String>, NoParams> {
  final ResearchRepository repository;

  GetResearchHistory(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams? params) async {
    return await repository.getSearchHistory();
  }
}
