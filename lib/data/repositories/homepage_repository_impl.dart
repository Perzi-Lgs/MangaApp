import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../constants/error_message_constant.dart';
import '../../core/errors/exception.dart';
import '../../core/network.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/manga_info.dart';
import '../../domain/repositories/homepage_repository.dart';
import '../data_sources/homepage_remote_data_source.dart';
import '../model/manga_info_model.dart';

class HomePageRepositoryImpl implements HomepageRepository {
  final HomepageRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const HomePageRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<MangaInfo>>> getListMangaPerSource(
      String sourceName) async {
    if (await networkInfo.isConnected) {
      try {
        final mangaList =
            await remoteDataSource.getListMangaInfoPerSource(sourceName);
        return Right(mangaList);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure(timeoutServerError));
    }
  }

  @override
  Future<Either<Failure, List<MangaInfo>>> getHomepageScans(
      String route, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final tmp = await remoteDataSource.getHomepageScans('/' + route, page);
        final List<MangaInfo> homePageManga = await Future.wait(tmp
            .map((e) async => e.copyWith(color: await _getDominantColor(e.img)))
            .toList());
        return Right(homePageManga);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure(timeoutServerError));
    }
  }

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
