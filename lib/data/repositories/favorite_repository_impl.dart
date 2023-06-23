import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/domain/entities/manga_info.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/domain/repositories/favorite_repository.dart';
import 'package:flutter/material.dart';

import '../data_sources/favorite_local_data_source.dart';
import '../model/manga_info_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;

  FavoriteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> getIsFavorite(MangaInfo data) async {
    try {
      final model = MangaInfoModel(
          author: data.author,
          img: data.img,
          name: data.name,
          url: data.url,
          color: data.color);
      final res = localDataSource.getIsFavorite(model);
      return Right(res);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> switchFavorite(MangaInfo data) async {
    try {
      final model = MangaInfoModel(
          author: data.author,
          img: data.img,
          name: data.name,
          url: data.url,
          color: Colors.black);
      localDataSource.switchFavorite(model);
      return Right(localDataSource.getIsFavorite(model));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<MangaInfo>>> getFavoriteList() async {
    try {
      return Right(localDataSource.getAllFavorite());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
