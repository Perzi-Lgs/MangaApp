import 'dart:convert';

import 'package:mobile/constants/error_message_constant.dart';
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/features/homepage/data/model/Link_model.dart';
import 'package:mobile/features/homepage/data/model/Manga_info_model.dart';
import 'package:http/http.dart' as http;

abstract class HomepageRemoteDataSource {
  Future<List<MangaInfoModel>> getListMangaInfoPerSource(String source);
  Future<MangaInfoModel> getRandomScan();
}

class HomepageRemoteDataSourceImpl implements HomepageRemoteDataSource {
  final http.Client client;

  HomepageRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MangaInfoModel>> getListMangaInfoPerSource(String source) async {
    late http.Response response;

    try {
      response = await client.get(
        Uri.http('ip', 'path'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token a recup'
        }
      ).timeout(const Duration(seconds: 5));
    } catch (e) {
      throw ServerException(timeoutServerError);
    }

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      List<MangaInfoModel> result = [];
      for (var i = 0; i < data.length; i++) {
        result.add(MangaInfoModel.fromJson(data[i]));
      }
      return Future.value(result);
    } else {
      throw ServerException(response.statusCode.toString());
    }
  }

  @override
  Future<MangaInfoModel> getRandomScan() async {
    http.Response response;

    return MangaInfoModel(cover: "plop", linkMangaName: LinkModel(name: "plop",url: "plopi"), linkChapter: LinkModel(name: "chpt", url: "url"));

    try {
      response = await client.get(
        Uri.http('ip', 'path'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token a recup'
        }
      ).timeout(const Duration(seconds: 5));
    } catch (e) {
      throw ServerException(timeoutServerError);
    }

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));

      MangaInfoModel result = MangaInfoModel.fromJson(data);
      return Future.value(result);
    } else {
      throw ServerException(response.statusCode.toString());
    }
  }
}
