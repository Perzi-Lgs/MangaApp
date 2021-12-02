import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/usecases.dart';
import 'package:mobile/features/homepage/domain/usecases/get_list_manga_per_sources.dart';
import 'package:mobile/features/homepage/domain/usecases/get_random_scan.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final GetListMangaPerSource getListMangaPerSource;
  final GetRandomScan getRandomScan;
  
  HomepageBloc({required this.getListMangaPerSource, required this.getRandomScan}) : super(HomepageInitial()) {

    on<Update>(_onEventUpdate);
  }

  void _onEventUpdate(Update event, Emitter<HomepageState> emit) async {


    try {
      final rawRandomScan = await getRandomScan(NoParams());
      
      final data = rawRandomScan.fold((l) => throw Exception(l.message), (r) => r);
      print(data);
    } catch (e) {
      emit(Error(message: e.toString()));
    }

  }
}
