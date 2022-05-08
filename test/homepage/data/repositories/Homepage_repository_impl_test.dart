import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/constants/error_message_constant.dart';
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network.dart';
import 'package:mobile/data/data_sources/homepage_remote_data_source.dart';
import 'package:mobile/data/model/manga_info_model.dart';
import 'package:mobile/data/repositories/homepage_repository_impl.dart';
import 'package:mobile/domain/repositories/homepage_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'homepage_repository_impl_test.mocks.dart';

class THomepageRemoteDataSource extends Mock
    implements HomepageRemoteDataSource {}

class TNetworkInfo extends Mock implements NetworkInfo {}

@GenerateMocks([THomepageRemoteDataSource])
@GenerateMocks([TNetworkInfo])
main() {
  late HomePageRepositoryImpl repository;
  late MockTHomepageRemoteDataSource mockRemoteDataSource;
  late MockTNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTHomepageRemoteDataSource();
    mockNetworkInfo = MockTNetworkInfo();
    repository = HomePageRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tMangaInfoModel = MangaInfoModel(
      img: "testurlCover", url: 'testUrlchapter', name: 'testUrlname');

  test('Should be a subclass HomePageRepository', () {
    expect(repository, isA<HomePageRepository>());
  });

  group('device is online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((_) async => Future.value(true));
    });
    test('Should check if the device is online', () async {
      when(mockRemoteDataSource.getHomepageScans(any, any))
          .thenAnswer((_) async => [tMangaInfoModel]);

      try {
        repository.getHomepageScans('/home', 1);
      } catch (e) {}
      verify(mockNetworkInfo.isConnected);
    });
    test('Should get remote data when the call to remote data is successful',
        () async {
      when(mockRemoteDataSource.getHomepageScans(any, any))
          .thenAnswer((_) async => [tMangaInfoModel]);

      await repository.getHomepageScans('home', 1);

      verify(mockRemoteDataSource.getHomepageScans('/home', 1));
      verify(mockNetworkInfo.isConnected);
    });

    test(
      'should return server failure when the call to the server is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getHomepageScans(any, any))
            .thenThrow(ServerException(timeoutServerError));
        // act
        final result = await repository.getHomepageScans('home', 1);
        // assert
        verify(mockRemoteDataSource.getHomepageScans('/home', 1));
        expect(result, equals(Left(ServerFailure(timeoutServerError))));
      },
    );
  });

  group('Device offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(false));
    });

    test('Should return a ServerFailure when the GET is not successful',
        () async {
      when(mockRemoteDataSource.getHomepageScans(any, any))
          .thenThrow(ServerException(timeoutServerError));
      final result = await repository.getHomepageScans('/home', 1);
      expect(result, Left(ServerFailure(timeoutServerError)));
    });
  });
}
