import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/scan_image.dart';
import '../../../../domain/usecases/get_manga_scan.dart';

part 'mangareader_event.dart';
part 'mangareader_state.dart';

class MangareaderBloc extends Bloc<MangareaderEvent, MangareaderState> {
  GetMangaScan getMangaScan;

  MangareaderBloc({required this.getMangaScan}) : super(MangareaderState()) {
    on<GetScans>(_onGetScan);
  }

  void _onGetScan(GetScans event, Emitter<MangareaderState> emit) async {
    try {
      emit(state.copyWith(status: MangareaderStateStatus.loading));

      final mangaScan = await getMangaScan(Params(url: event.url));
      print(mangaScan);
      mangaScan.fold(
          (l) => emit(state.copyWith(status: MangareaderStateStatus.failure)),
          (r) => emit(state.copyWith(
              status: MangareaderStateStatus.success, images: r)));
    } catch (e) {
      emit(state.copyWith(status: MangareaderStateStatus.failure));
    }
  }
}
