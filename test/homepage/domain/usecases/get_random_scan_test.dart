import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/usecases.dart';
import 'package:mobile/features/homepage/domain/entities/MangaInfo.dart';
import 'package:mobile/features/homepage/domain/entities/MangaLink.dart';
import 'package:mobile/features/homepage/domain/repositories/HomePage_repository.dart';
import 'package:mobile/features/homepage/domain/usecases/get_random_scan.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_random_scan.mocks.dart';

class TestHomePageRepository extends Mock implements HomePageRepository {}

@GenerateMocks([TestHomePageRepository])
void main() {
  late GetRandomScan usecase;
  late MockTestHomePageRepository testDashboardRepository;

  setUp(() {
    testDashboardRepository = MockTestHomePageRepository();
    usecase = GetRandomScan(testDashboardRepository);
  });

  final mangaInfo = MangaInfo(
      cover: "fakeUrl.com",
      linkMangaName: MangaLink(url: "mangaLink", name: "Manga Name"),
      linkChapter: MangaLink(url: "ChapterLink", name: "Chapter 42"));

  test('should get MangaInfo from the repository', () async {
    // Mock the repository to send a MangaInfo whatever the parameters
    when(testDashboardRepository.getRandomScan())
        .thenAnswer((_) async => Right(mangaInfo));

    //Await the result of the usecase
    final result = await usecase(NoParams());

    expect(result, Right(mangaInfo));
    //Verify that the method has been called on the Repository
    verify(testDashboardRepository.getRandomScan());
    //Verify the repository is only doing the task is has been called for
    verifyNoMoreInteractions(testDashboardRepository);
  });
}
