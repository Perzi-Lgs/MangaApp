import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/constants/error_message_constant.dart';
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network.dart';
import 'package:mobile/features/homepage/data/datasources/Homepage_remote_data_source.dart';
import 'package:mobile/features/homepage/data/model/Link_model.dart';
import 'package:mobile/features/homepage/data/model/Manga_info_model.dart';
import 'package:mobile/features/homepage/data/repositories/HomePage_repository_impl.dart';
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

  final tLinkChapter = LinkModel(url: 'testUrlchapter', name: 'chapter');
  final tLinkName = LinkModel(url: 'testUrlname', name: 'name');
  final tMangaInfoModel = MangaInfoModel(
      cover: "testurlCover",
      linkChapter: tLinkChapter,
      linkMangaName: tLinkName);

  test('Should be a subclass HomePageRepository', () {
    expect(repository, isA<HomePageRepository>());
  });

  group('device is online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((_) async => Future.value(true));
    });
    test('Should check if the device is online', () async {
      when(mockRemoteDataSource.getRandomScan())
          .thenAnswer((_) async => tMangaInfoModel);

      repository.getRandomScan();
      verify(mockNetworkInfo.isConnected);
    });
    test('Should get remote data when the call to remote data is successful',
        () async {
      late final result;

      when(mockRemoteDataSource.getRandomScan())
          .thenAnswer((_) async => tMangaInfoModel);

      result = await repository.getRandomScan();

      verify(mockRemoteDataSource.getRandomScan());
      expect(result, equals(Right(tMangaInfoModel)));
      verify(mockNetworkInfo.isConnected);
    });

    test(
      'should return server failure when the call to the server is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getRandomScan())
            .thenThrow(ServerException(timeoutServerError));
        // act
        final result = await repository.getRandomScan();
        // assert
        verify(mockRemoteDataSource.getRandomScan());
        expect(result, equals(Left(ServerFailure(timeoutServerError))));
      },
    );
    //   test('Should return Future MangaInfoModel when the GET is successful', () async {
    //     final tStepsModel = StepsModel(stepsMade: 10, day: 1);
    //     when(mockRemoteDataSource.sendTodaySteps(tStepsModel))
    //         .thenAnswer((_) => (Future.value(Right(0))));
    //     await repository.sendSteps(tStepsModel);
    //     verify(mockRemoteDataSource.sendTodaySteps(tStepsModel));
    //   });
    // });

    group('Device offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) => Future.value(false));
      });

      test('Should return a ServerFailure when the GET is not successful',
          () async {
        when(mockRemoteDataSource.getRandomScan())
            .thenThrow(ServerException(timeoutServerError));
        final result = await repository.getRandomScan();
        expect(result, Left(ServerFailure(timeoutServerError)));
      });
    });
  });
}
