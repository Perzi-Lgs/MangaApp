import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../../../../domain/repositories/research_repository.dart';

class DeleteSearchInHistory extends UseCase<List<String>, DeleteSearchInHistoryParams> {
  final ResearchRepository repository;

  DeleteSearchInHistory(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(DeleteSearchInHistoryParams? params) async {
    return await repository.deleteSearchInHistory(params!.query);
  }
}

class DeleteSearchInHistoryParams extends Equatable {
  final String query;

  DeleteSearchInHistoryParams({required this.query});

  @override
  List<Object?> get props => [query];
}
