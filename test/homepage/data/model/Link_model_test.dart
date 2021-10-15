import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/homepage/data/model/Link_model.dart';
import 'package:mobile/features/homepage/domain/entities/MangaLink.dart';

import '../../../fixtures/fixtures_reader.dart';

void main() {
  final tlinkModel = LinkModel(
    url: 'testUrl',
    name: 'test',
  );

  test(
    'should be a subclass of MangaLink entity',
    () async {
      expect(tlinkModel, isA<MangaLink>());
    },
  );

  group('from JSON', () {
    test('should return a valid model when the JSON contains String', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('link_model.json'));

      final result = LinkModel.fromJson(jsonMap);

      expect(result, tlinkModel);
    });
  });

  group('to JSON', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tlinkModel.toJson();

      final expectedJsonMap = {"url": 'testUrl', "name": 'test'};
      expect(result, expectedJsonMap);
    });
  });
}
