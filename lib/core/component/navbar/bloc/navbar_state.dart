part of 'navbar_bloc.dart';

abstract class NavbarState extends Equatable {
  final int index;
  const NavbarState(this.index);

  @override
  List<Object> get props => [];
}

class NavbarInitial extends NavbarState {
  NavbarInitial({required int index}) : super(index);
}

class NavbarLoading extends NavbarState {
  NavbarLoading({required int index}) : super(index);
}

class NavbarUpdated extends NavbarState {
  NavbarUpdated({required int index}) : super(index);
}
