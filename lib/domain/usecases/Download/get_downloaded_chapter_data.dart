import 'dart:ffi';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../../repositories/download_repository.dart';

class GetDownloadedChapterData
    extends UseCase<List<Uint8List>, GetDownloadedChapterDataParams> {
  final DownloadRepository repository;

  GetDownloadedChapterData(this.repository);

  @override
  Future<Either<Failure, List<Uint8List>>> call(
      GetDownloadedChapterDataParams? params) async {
    return await repository.getDownloadedChapterData(params!.mangaName, params.chapter);
  }
}

class GetDownloadedChapterDataParams extends Equatable {
  final String chapter;
  final String mangaName;

  GetDownloadedChapterDataParams({required this.chapter, required this.mangaName});

  @override
  List<Object?> get props => [chapter, mangaName];
}
