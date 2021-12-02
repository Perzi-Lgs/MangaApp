import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/homepage/data/model/Link_model.dart';
import 'package:mobile/features/homepage/data/model/Manga_info_model.dart';
import 'package:mobile/features/homepage/domain/entities/MangaInfo.dart';

import '../../../fixtures/fixtures_reader.dart';

void main() {
  final tLinkChapter = LinkModel(url: 'testUrlchapter', name: 'chapter');
  final tLinkName = LinkModel(url: 'testUrlname', name: 'name');
  final tMangaInfoModel = MangaInfoModel(
      cover: "testurlCover",
      linkChapter: tLinkChapter,
      linkMangaName: tLinkName);

  test(
    'should be a subclass of Mangainfo entity',
    () async {
      expect(tMangaInfoModel, isA<MangaInfo>());
    },
  );

  group('from JSON', () {
    test('should return a valid model when the JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('Manga_info.json'));

      final result = MangaInfoModel.fromJson(jsonMap);

      expect(result, tMangaInfoModel);
    });
  });

  group('to JSON', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tMangaInfoModel.toJson();

      final expectedJsonMap = {
        "cover": "testurlCover",
        "linkMangaName": {"url": "testUrlname", "name": "name"},
        "linkChapter": {"url": "testUrlchapter", "name": "chapter"}
      };
      expect(result, expectedJsonMap);
    });
  });
}
