import 'dart:convert';

import '../../constants/error_message_constant.dart';
import '../../core/errors/exception.dart';
import '../model/scan_image_model.dart';
import 'package:http/http.dart' as http;


abstract class ScanMangaRemoteDatasource {
  Future<List<ScanImageModel>> getMangaInfoPage(String url);
}

class ScanMangaRemoteDatasourceImpl extends ScanMangaRemoteDatasource {
  final http.Client client;

  ScanMangaRemoteDatasourceImpl({required this.client});
  
  @override
  Future<List<ScanImageModel>> getMangaInfoPage(String url) async {
    http.Response response;

    try {
      response = await client.get(
          Uri.http('35.180.230.94', 'scan', {'url': url}),
          headers: {
            'Content-Type': 'application/json',
          }).timeout(const Duration(seconds: 5));
    } catch (e) {
      throw ServerException(timeoutServerError);
    }

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      List<ScanImageModel> result = [];
      for (var i = 0; i < data.length; i++) {
        result.add(ScanImageModel.fromJson(data[i]));
      }
      return Future.value(result);
    } else {
      throw ServerException(response.statusCode.toString());
    }
  }
}
