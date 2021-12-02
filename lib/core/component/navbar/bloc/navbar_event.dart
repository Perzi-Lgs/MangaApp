part of 'navbar_bloc.dart';

abstract class NavbarEvent extends Equatable {
  const NavbarEvent();

  @override
  List<Object> get props => [];
}

class UpdateNavabar extends NavbarEvent {
  final index;

  const UpdateNavabar({required this.index});
}