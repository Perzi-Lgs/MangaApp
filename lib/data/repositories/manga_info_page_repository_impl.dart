import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../constants/error_message_constant.dart';
import '../../core/errors/exception.dart';
import '../../core/network.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/complete_manga_info.dart';
import '../../domain/repositories/manga_info_repository.dart';
import '../data_sources/manga_info_page_remote_data_source.dart';

class MangaInfoPageRepositoryImpl implements MangaInfoPageRepository {
  final MangaInfoPageRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;

  const MangaInfoPageRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, CompleteMangaInfo>> getFullMangaInfo(String url) async {
    if (await networkInfo.isConnected) {
      try {
        final tmp = await remoteDataSource.getMangaInfoPage(url);
        final completeMangaInfo = tmp.copyWith(color: await _getDominantColor(tmp.img));
        return Right(completeMangaInfo);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure(timeoutServerError));
    }
  }

  // TODO : move this fct in a data source
  Future<Color> _getDominantColor(String url) async {
    final Image img = Image.network(
      url,
      headers: {'Referer': 'https://readmanganato.com/'},
      fit: BoxFit.fill,
    );
    final palette = await PaletteGenerator.fromImageProvider(img.image);

    return palette.darkMutedColor?.color ?? Colors.black;
  }

}
