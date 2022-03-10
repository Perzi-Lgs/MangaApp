import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_manga_full_info.dart';

part 'mangainfo_event.dart';
part 'mangainfo_state.dart';

class MangainfoBloc extends Bloc<MangainfoEvent, MangainfoState> {
  GetFullMangaInfo getFullMangaInfo;

  MangainfoBloc({required this.getFullMangaInfo}) : super(MangainfoInitial()) {
    on<MangainfoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
