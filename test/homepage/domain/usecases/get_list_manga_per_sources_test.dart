import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/domain/entities/manga_info.dart';
import 'package:mobile/domain/repositories/HomePage_repository.dart';
import 'package:mobile/domain/usecases/get_list_manga_per_sources.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_list_manga_per_sources_test.mocks.dart';

class TestHomepageRepository extends Mock implements HomepageRepository {}

@GenerateMocks([TestHomepageRepository])
void main() {
  late GetListMangaPerSource usecase;
  late MockTestHomepageRepository testDashboardRepository;

  setUp(() {
    testDashboardRepository = MockTestHomepageRepository();
    usecase = GetListMangaPerSource(testDashboardRepository);
  });

  final listMangaInfo = [
    MangaInfo(img: 'img', name: 'name', url: 'url')
  ];

  test('should get MangaInfo List from the repository', () async {
    // Mock the repository to send a List<MangaInfo> with the source as parameter
    when(testDashboardRepository.getListMangaPerSource(any))
        .thenAnswer((_) async => Right(listMangaInfo));

    //Await the result of the usecase
    final result = await usecase(Params(sourceName: 'mangaRock'));

    expect(result, Right(listMangaInfo));
    //Verify that the method has been called on the Repository
    verify(testDashboardRepository.getListMangaPerSource("mangaRock"));
    //Verify the repository is only doing the task is has been called for
    verifyNoMoreInteractions(testDashboardRepository);
  });
}
