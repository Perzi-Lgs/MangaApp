import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../repositories/search_repository.dart';
import '../entities/manga_info.dart';

class GetSearchScans extends UseCase<List<MangaInfo>, Params> {
  final SearchRepository repository;

  GetSearchScans(this.repository);

  @override
  Future<Either<Failure, List<MangaInfo>>> call(Params? params) async {
    return await repository.getSearchScans(params!.query, params.page);
  }
}

class Params extends Equatable {
  final String query;
  final int page;

  Params({required this.query, this.page = 1});

  @override
  List<Object?> get props => [query, page];
}
