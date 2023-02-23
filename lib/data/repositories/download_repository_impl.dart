import 'dart:typed_data';

import 'package:mobile/domain/entities/chapter.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/domain/entities/scan_image.dart';
import 'package:mobile/domain/repositories/download_repository.dart';

import '../../core/network.dart';
import '../../domain/entities/manga_info.dart';
import '../data_sources/download_data_sources/download_data_source.dart';
import '../data_sources/scan_manga_remote_datasource.dart';

class DownloadRepositoryImpl implements DownloadRepository {
  final ScanMangaRemoteDatasource scanMangaRemoteDatasource;
  final DownloadDataSource downloadLocalDataSource;
  final NetworkInfo networkInfo;

  DownloadRepositoryImpl(
      {required this.downloadLocalDataSource,
      required this.networkInfo,
      required this.scanMangaRemoteDatasource});

  @override
  Future<Either<Failure, bool>> downloadChapter(MangaInfo info, Chapter chapter,
      void Function(int status, double progress) statusCallback) async {
    try {
      if (await networkInfo.isConnected) {
        final List<ScanImage> scans =
            await scanMangaRemoteDatasource.getMangaInfoPage(chapter.url);
        final bool cacheResult = await downloadLocalDataSource.storeInfoInCache(
            info.name, chapter.name);

        if (!cacheResult) {
          return Left(CacheFailure('Cache Error'));
        }
        downloadLocalDataSource.downloadScans(
            info.name + '/' + chapter.name, scans, statusCallback);
        return Right(true);
      } else {
        return Left(InternetFailure('No Internet'));
      }
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<String>>> getDownloadedManga() async {
    try {
      try {
        return Right(await downloadLocalDataSource.getDownloadedManga());
      } catch (e) {
        return Left(CacheFailure(e.toString()));
      }
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getdownloadedMangaChapters(
      String name) async {
    try {
      try {
        return Right(await downloadLocalDataSource.getDownloadedMangaChapters(name));
      } catch (e) {
        return Left(CacheFailure(e.toString()));
      }
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Uint8List>>> getDownloadedChapterData(String mangaName, String chapter) async {
    return Right(await downloadLocalDataSource.getDownloadedChapterData(mangaName, chapter));
  }
}
