import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/bookmark.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final SetLastRead setLastReadUsecase;
  final GetLastRead getLastReadUsecase;
  final GetAllRead getAllReadUsecase;

  BookmarkCubit(
      {required this.getAllReadUsecase,
      required this.setLastReadUsecase,
      required this.getLastReadUsecase})
      : super(BookmarkState(allRead: [], lastRead: "", hasFailed: false));

  void setLastRead(String lastChapterRead, String mangaName) async {
    if (mangaName == "") return;
    final res = await setLastReadUsecase(SetLastReadParams(
        lastChapterRead: lastChapterRead, mangaName: mangaName));

    res.fold((l) => emit(state.copyWith(hasFailed: true)),
        (r) => emit(state.copyWith(hasFailed: false)));
  }

  void getLastRead(String mangaName) async {
    if (mangaName == "") return;
    
    final res = await getLastReadUsecase(GetReadParams(mangaName: mangaName));

    res.fold((l) => emit(state.copyWith(hasFailed: true)),
        (r) => emit(state.copyWith(hasFailed: false, lastRead: r)));
  }

  void getAllRead(String mangaName) async {
    if (mangaName == "") return;
    final res = await getAllReadUsecase(GetReadParams(mangaName: mangaName));

    res.fold((l) => emit(state.copyWith(hasFailed: true)),
        (r) => emit(state.copyWith(hasFailed: false, allRead: r)));
  }
}

class BookmarkState extends Equatable {
  final String lastRead;
  final List<String> allRead;
  final bool hasFailed;

  const BookmarkState(
      {required this.allRead, required this.lastRead, required this.hasFailed});

  BookmarkState copyWith(
      {List<String>? allRead, String? lastRead, bool? hasFailed}) {
    return BookmarkState(
        allRead: allRead ?? this.allRead,
        lastRead: lastRead ?? this.lastRead,
        hasFailed: hasFailed ?? this.hasFailed);
  }

  @override
  List<Object> get props => [allRead, lastRead, hasFailed];
}
