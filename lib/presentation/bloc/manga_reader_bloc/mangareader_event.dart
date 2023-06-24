part of 'mangareader_bloc.dart';

abstract class MangareaderEvent extends Equatable {
  const MangareaderEvent();

  @override
  List<Object> get props => [];
}

class GetScans extends MangareaderEvent {
  const GetScans({required this.index, required this.url});
  
  final String url;
  final int index;

  @override
  List<Object> get props => [url, index];
}
