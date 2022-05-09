import '../../../core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SearchLocalDataSource {
  Future<bool> saveSearchHistory(List<String> queries);
  Future<List<String>> deleteSearchInHistory(String queries);
  Future<List<String>> getSearchHistory();
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final SharedPreferences sharedPreferences;

  SearchLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<String>> getSearchHistory() async {
    // TODO : peut etre utiliser la fct reload
    final res = sharedPreferences.getStringList('SEARCH_HISTORY');
    if (res != null) {
      return Future.value(res);
    } else {
      saveSearchHistory([]);
      return Future.value([]);
    }
  }

  @override
  Future<bool> saveSearchHistory(List<String> queries) async {
    return await sharedPreferences.setStringList('SEARCH_HISTORY', queries);
  }

  @override
  Future<List<String>> deleteSearchInHistory(String query) async {
    try {
      List<String> history = await getSearchHistory();
      history.remove(query);
      await saveSearchHistory(history);
      return Future.value(history);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
