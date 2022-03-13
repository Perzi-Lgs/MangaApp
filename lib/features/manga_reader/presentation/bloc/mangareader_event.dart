part of 'mangareader_bloc.dart';

abstract class MangareaderEvent extends Equatable {
  const MangareaderEvent();

  @override
  List<Object> get props => [];
}

class GetScans extends MangareaderEvent {
  const GetScans({required this.url});
  
  final String url;

  @override
  List<Object> get props => [url];
}
