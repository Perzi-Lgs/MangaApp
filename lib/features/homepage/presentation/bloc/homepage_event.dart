part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class Update extends HomepageEvent {
  const Update();

  @override
  List<Object> get props => [];
}