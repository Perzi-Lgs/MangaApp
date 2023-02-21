import 'dart:convert';

import '../../constants/error_message_constant.dart';
import '../../core/errors/exception.dart';
import 'package:http/http.dart' as http;

import '../model/complete_manga_info_model.dart';

abstract class MangaInfoPageRemoteDatasource {
  Future<CompleteMangaInfoModel> getMangaInfoPage(String url);
}

class MangaInfoPageRemoteDatasourceImpl implements MangaInfoPageRemoteDatasource {
  final http.Client client;

  MangaInfoPageRemoteDatasourceImpl({required this.client});

  @override
  Future<CompleteMangaInfoModel> getMangaInfoPage(String url) async {
    http.Response response;

    try {
      response = await client.get(
        Uri.http('35.180.192.181', 'mangaData', {'source': url}),
        headers: {
          'Content-Type': 'application/json',
        }
      ).timeout(const Duration(seconds: 5));
    } catch (e) {
      throw ServerException(timeoutServerError);
    }

    if (response.statusCode == 200) {
      CompleteMangaInfoModel data = CompleteMangaInfoModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return Future.value(data);
    } else {
      throw ServerException(response.statusCode.toString());
    }
  }
}