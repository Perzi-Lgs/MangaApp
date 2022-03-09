import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/constants/error_message_constant.dart';
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network.dart';
import 'package:mobile/features/homepage/data/datasources/Homepage_remote_data_source.dart';
import 'package:mobile/features/homepage/data/model/Manga_info_model.dart';
import 'package:mobile/features/homepage/data/repositories/HomePage_repository_impl.dart';
import 'package:mobile/features/homepage/domain/entities/MangaInfo.dart';
import 'package:mobile/features/homepage/domain/repositories/HomePage_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'Homepage_repository_impl_test.mocks.dart';

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
      img: "testurlCover",
      url: 'testUrlchapter',
      name: 'testUrlname');
  
  final tMangaInfo = MangaInfo(
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
      when(mockRemoteDataSource.getHomepageScans(any))
          .thenAnswer((_) async => [tMangaInfoModel]);

      try {
        repository.getHomepageScans('/home');
      } catch (e) {}
      verify(mockNetworkInfo.isConnected);
    });
    test('Should get remote data when the call to remote data is successful',
        () async {
      late final result;

      when(mockRemoteDataSource.getHomepageScans(any))
          .thenAnswer((_) async => [tMangaInfoModel]);

      result = await repository.getHomepageScans('home');

      verify(mockRemoteDataSource.getHomepageScans('/home'));
      verify(mockNetworkInfo.isConnected);
    });

    test(
      'should return server failure when the call to the server is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getHomepageScans(any))
            .thenThrow(ServerException(timeoutServerError));
        // act
        final result = await repository.getHomepageScans('home');
        // assert
        verify(mockRemoteDataSource.getHomepageScans('/home'));
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
        when(mockRemoteDataSource.getHomepageScans(any))
            .thenThrow(ServerException(timeoutServerError));
        final result = await repository.getHomepageScans('/home');
        expect(result, Left(ServerFailure(timeoutServerError)));
      });
    });
}
