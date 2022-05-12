import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ListSelectorCubit extends Cubit<ListSelectorCubitState> {
  ListSelectorCubit(int size)
      : super(ListSelectorCubitState(
            list: List.generate(size, (index) => false)));

  void select(int index) {
    List<bool> tmp = List.from(state.list);
    tmp[index] = !tmp[index];
    emit(state.copyWith(list: tmp));
  }

  void selectAll() {
    emit(state.copyWith(
        list: List.generate(state.list.length, (index) => true)));
  }
}

class ListSelectorCubitState extends Equatable {
  final List<bool> list;

  ListSelectorCubitState({required this.list});

  ListSelectorCubitState copyWith({List<bool>? list}) {
    return ListSelectorCubitState(list: list ?? this.list);
  }

  @override
  List<Object?> get props => [list];
}
