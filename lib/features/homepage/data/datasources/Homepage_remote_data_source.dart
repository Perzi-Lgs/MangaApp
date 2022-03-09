import 'dart:convert';

import 'package:mobile/constants/error_message_constant.dart';
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/features/homepage/data/model/Manga_info_model.dart';
import 'package:http/http.dart' as http;

abstract class HomepageRemoteDataSource {
  Future<List<MangaInfoModel>> getListMangaInfoPerSource(String source);
  Future<List<MangaInfoModel>> getHomepageScans(String route);
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
  Future<List<MangaInfoModel>> getHomepageScans(String route) async {
    http.Response response;

    print(route);
    try {
      response = await client.get(
        Uri.http('15.237.95.78:80', route),
          // Uri.http('192.168.43.221:6868', route),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'token a recup'
        }
      ).timeout(const Duration(seconds: 5));
    } catch (e) {
      throw ServerException(timeoutServerError);
    }

    if (response.statusCode == 200) {
      Iterable result = jsonDecode(utf8.decode(response.bodyBytes));
      List<MangaInfoModel> data = List<MangaInfoModel>.from(result.map((model) => MangaInfoModel.fromJson(model)));
      return Future.value(data);
    } else {
      throw ServerException(response.statusCode.toString());
    }
  }
}