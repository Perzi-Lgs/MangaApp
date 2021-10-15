import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../entities/MangaInfo.dart';
import '../repositories/HomePage_repository.dart';

class GetRandomScan extends UseCase<MangaInfo, NoParams> {
  final HomePageRepository repository;

  GetRandomScan(this.repository);

  @override
  Future<Either<Failure, MangaInfo>> call(NoParams? params) async {
    return await repository.getRandomScan();
  }
}
