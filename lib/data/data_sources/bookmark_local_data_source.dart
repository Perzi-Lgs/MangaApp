import 'package:mobile/core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BookmarkLocalDataSource {
  String getLastRead(String mangaName);
  Future<bool> setLastRead(String mangaName, String lastChapterRead);
  Future<bool> setAllRead(String mangaName, String lastChapterRead);
  List<String> getAllRead(String mangaName);
}

class BookmarkLocalDataSourceImpl implements BookmarkLocalDataSource {
  final SharedPreferences sharedPreferences;

  BookmarkLocalDataSourceImpl({required this.sharedPreferences});

  @override
  String getLastRead(String mangaName) {
    try {
      final String? res = sharedPreferences.getString(mangaName);
      if (res == null) {
        return "";
      }
      return res;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  List<String> getAllRead(String mangaName) {
    try {
      final List<String>? res =
          sharedPreferences.getStringList(mangaName + "List");
      if (res == null) {
        return [];
      }
      return res;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> setLastRead(String mangaName, String lastChapterRead) async {
    try {
      return await sharedPreferences.setString(mangaName, lastChapterRead);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> setAllRead(String mangaName, String chapterRead) async {
    try {
      final List<String>? res =
          sharedPreferences.getStringList(mangaName + "List");

      if (res == null)
        return await sharedPreferences
            .setStringList(mangaName + "List", [chapterRead]);
      else {
        if (res.contains(chapterRead)) {
          return true;
        }
        res.add(chapterRead);
        return await sharedPreferences.setStringList(mangaName + "List", res);
      }
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
