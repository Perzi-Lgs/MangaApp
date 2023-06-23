import 'dart:convert';

import 'package:mobile/core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/manga_info_model.dart';

abstract class FavoriteLocalDataSource {
  bool switchFavorite(MangaInfoModel info);
  bool getIsFavorite(MangaInfoModel info);
  List<MangaInfoModel> getAllFavorite();
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoriteLocalDataSourceImpl({required this.sharedPreferences});

  @override
  bool getIsFavorite(MangaInfoModel info) {
    final List<String>? res = sharedPreferences.getStringList("favorite");

    if (res == null) {
      return false;
      
    }
    return res.contains(jsonEncode(info.toJson()));
  }

  @override
  bool switchFavorite(MangaInfoModel info) {
    try {
      final List<String>? res = sharedPreferences.getStringList("favorite");
      if (res != null) {
        final isHere = res.contains(jsonEncode(info.toJson()));
        if (isHere) {
          res.removeWhere((item) => item == jsonEncode(info.toJson()));
          sharedPreferences.setStringList("favorite", res);
          return false;
        } else {
          res.add(jsonEncode(info.toJson()));
          sharedPreferences.setStringList("favorite", res);
          return true;
        }
      } else {
        sharedPreferences.setStringList("favorite", [jsonEncode(info.toJson())]);
        return true;
      }
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  List<MangaInfoModel> getAllFavorite() {
    try {
      final List<String>? favList = sharedPreferences.getStringList("favorite");
      List<MangaInfoModel> res = List.empty(growable: true);
      if (favList != null) {
        for (var i in favList) {
          res.add(MangaInfoModel.fromJson(jsonDecode(i)));
        }
        return res;
      }
      return List.empty();
    } catch (e) {
      throw CacheException(e.toString());      
    }
  }

}