import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarInitial(index: 0)) {
    on<UpdateNavabar>(_onNavbarClicked);
  }

  void _onNavbarClicked(UpdateNavabar event, Emitter<NavbarState> emit) async {
    emit(NavbarLoading(index: 0));
    return emit(NavbarUpdated(index: event.index));
  }
}
