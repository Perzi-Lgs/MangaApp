import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/features/homepage/data/datasources/Homepage_remote_data_source.dart';
import 'package:mobile/features/homepage/data/model/Manga_info_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixtures_reader.dart';
import 'homepage_remote_data_source_test.mocks.dart';


class THttpClient extends Mock implements http.Client {}

@GenerateMocks([THttpClient])
void main() {
  late HomepageRemoteDataSourceImpl dataSource;
  late MockTHttpClient mockHttpClient;

  setUp(() async {
    mockHttpClient = MockTHttpClient();
    dataSource = HomepageRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpWithFailure500() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('bad_request.json'), 500));
  }

  void setUpMockHttpWithSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('mangaInfoList.json'), 200));
  }

  // void setUpMockHttpWithTimeoutException() {
  //   when(mockHttpClient.get(any, headers: anyNamed('headers')))
  //       .thenThrow((_) async => TimeoutException("message"));
  // }
  
  final List<MangaInfoModel> tMangaInfoList = [
    MangaInfoModel(img: 'img', name: 'name', url: 'url'),
    MangaInfoModel(img: 'img', name: 'name', url: 'url'),
  ];

  group('getListMangaInfoPerSource', () {
    test('''should preform a GET request on the
        server url and with application/json header''', () async {
      setUpMockHttpWithSuccess200();

      dataSource.getListMangaInfoPerSource('source');
      verify(mockHttpClient.get(Uri.http('ip', 'path'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'token a recup'
      }));
    });
    // test('should timeout if the server doesnt answer', () {
    //   setUpMockHttpWithTimeoutException();
    //   when(mockHttpClient.get(any, headers: anyNamed('headers')))
    //       .thenThrow((_) async => TimeoutException("message"));

    //   final call = dataSource.getRandomScan;
    //   expect(() => call(),
    //       throwsA(TypeMatcher<ServerException>()));
    // });

    test('''should return List<MangaInfoModel> when the answer is 200''', () async {
      setUpMockHttpWithSuccess200();
      final result = await dataSource.getListMangaInfoPerSource('source');
      expect(result, tMangaInfoList);
    });

    test('''should return an exception when the answer is not 200''', () async {
      final call = dataSource.getListMangaInfoPerSource;

      setUpMockHttpWithFailure500();
      expect(() => call('source'),
          throwsA(TypeMatcher<ServerException>()));
    });
  });

  // group('getRandomScan', () {
  //   test('''should preform a GET request on the
  //       server url and with application/json header''', () {
  //     when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
  //         (_) async => http.Response(fixture('Manga_info.json'), 200));

  //     dataSource.getRandomScan();
  //     verify(mockHttpClient.get(Uri.http('ip', 'path'),
  //         headers: {'Content-Type': 'application/json',  'Authorization': 'token a recup'
  //     }));
  //   });

  //   test('should timeout if the server doesnt answer', () {
  //     setUpMockHttpWithTimeoutException();
  //     when(mockHttpClient.get(any, headers: anyNamed('headers')))
  //         .thenThrow((_) async => TimeoutException("message"));

  //     final call = dataSource.getRandomScan;
  //     expect(() => call(), throwsA(TypeMatcher<ServerException>()));
  //   });
  // });
}
