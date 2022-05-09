import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/domain/repositories/homepage_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../entities/manga_info.dart';

class GetListMangaPerSource extends UseCase<List<MangaInfo>, Params> {
  final HomepageRepository repository;

  GetListMangaPerSource(this.repository);

  @override
  Future<Either<Failure, List<MangaInfo>>> call(Params? params) async {
    return await repository.getListMangaPerSource(params!.sourceName);
  }
}

class Params extends Equatable {
  final String sourceName;

  Params({required this.sourceName});

  @override
  List<Object?> get props => [];
}
