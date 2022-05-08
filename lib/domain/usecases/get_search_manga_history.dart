import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../repositories/search_repository.dart';

class GetSearchHistory extends UseCase<List<String>, NoParams> {
  final SearchRepository repository;

  GetSearchHistory(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams? params) async {
    return await repository.getSearchHistory();
  }
}
