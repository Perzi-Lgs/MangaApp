import 'package:mobile/features/homepage/data/model/Manga_info_model.dart';

abstract class HomepageRemoteDataSource {
  Future<List<MangaInfoModel>> getListMangaInfoPerSource(String source);
  Future<MangaInfoModel> getRandomScan();
}

class HomepageRemoteDataSourceImpl implements HomepageRemoteDataSource {
  @override
  Future<List<MangaInfoModel>> getListMangaInfoPerSource(String source) {
    // TODO: implement getListMangaInfoPerSource
    throw UnimplementedError();
  }

  @override
  Future<MangaInfoModel> getRandomScan() {
    // TODO: implement getRandomScan
    throw UnimplementedError();
  }
}
