import 'dart:convert';

import '../../../../constants/error_message_constant.dart';
import '../../../../core/errors/exception.dart';
import 'package:http/http.dart' as http;

import '../../model/Manga_info_model.dart';

abstract class ResearchRemoteDataSource {
  Future<List<MangaInfoModel>> getResearchScans(String query, int page);
}

class ResearchRemoteDataSourceImpl implements ResearchRemoteDataSource {
  final http.Client client;

  ResearchRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MangaInfoModel>> getResearchScans(String query, int page) async {
    late http.Response response;

    try {
      response = await client.get(
          Uri.http('35.180.230.94', 'search',
              {'search': query, 'page': page.toString()}),
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'token a recup'
          }).timeout(const Duration(seconds: 5));
      print(response);
    } catch (e) {
      throw ServerException(timeoutServerError);
    }

    if (response.statusCode == 200) {
      Iterable result = jsonDecode(utf8.decode(response.bodyBytes));
      List<MangaInfoModel> data = List<MangaInfoModel>.from(
          result.map((model) => MangaInfoModel.fromJson(model)));
      return Future.value(data);
    } else {
      throw ServerException(response.statusCode.toString());
    }
  }
}
