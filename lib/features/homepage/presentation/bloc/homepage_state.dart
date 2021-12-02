part of 'homepage_bloc.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();
  
  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {
  const HomepageInitial();
  
  @override
  List<Object> get props => [];
}

class HomepageIsLoading extends HomepageState {
  const HomepageIsLoading();
  
  @override
  List<Object> get props => [];
}

class HomepageLoaded extends HomepageState {
  const HomepageLoaded();

  @override
  List<Object> get props => [];

}

class Error extends HomepageState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
