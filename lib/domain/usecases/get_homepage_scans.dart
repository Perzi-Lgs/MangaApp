import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../entities/manga_info.dart';
import '../repositories/homepage_repository.dart';

class GetHomepageScans extends UseCase<List<MangaInfo>, Params> {
  final HomepageRepository repository;

  GetHomepageScans(this.repository);

  @override
  Future<Either<Failure, List<MangaInfo>>> call(Params? params) async {
    return await repository.getHomepageScans(params!.route, params.page);
  }
}
class Params extends Equatable {
  final String route;
  final int page;

  Params({required this.route, this.page = 1});

  @override
  List<Object?> get props => [route, page];
}
