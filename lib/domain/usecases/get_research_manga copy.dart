import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../../../../domain/repositories/research_repository.dart';
import '../entities/MangaInfo.dart';

class GetResearchScans extends UseCase<List<MangaInfo>, Params> {
  final ResearchRepository repository;

  GetResearchScans(this.repository);

  @override
  Future<Either<Failure, List<MangaInfo>>> call(Params? params) async {
    return await repository.getResearchScans(params!.query, params.page);
  }
}

class Params extends Equatable {
  final String query;
  final int page;

  Params({required this.query, this.page = 1});

  @override
  List<Object?> get props => [query, page];
}
