import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../entities/MangaInfo.dart';
import '../repositories/HomePage_repository.dart';

class GetHomepageScans extends UseCase<List<MangaInfo>, Params> {
  final HomePageRepository repository;

  GetHomepageScans(this.repository);

  @override
  Future<Either<Failure, List<MangaInfo>>> call(Params? params) async {
    return await repository.getHomepageScans(params!.route);
  }
}
class Params extends Equatable {
  final String route;

  Params({required this.route});

  @override
  List<Object?> get props => [route];
}
