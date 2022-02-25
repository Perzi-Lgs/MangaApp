import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../entities/MangaInfo.dart';
import '../repositories/HomePage_repository.dart';

class GetHomepageScans extends UseCase<List<MangaInfo>, NoParams> {
  final HomePageRepository repository;

  GetHomepageScans(this.repository);

  @override
  Future<Either<Failure, List<MangaInfo>>> call(NoParams? params) async {
    return await repository.getHomepageScans();
  }
}
