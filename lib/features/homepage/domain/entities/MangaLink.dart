import 'package:equatable/equatable.dart';

class MangaLink extends Equatable {
  final String url;
  final String name;

  MangaLink({required this.url, required this.name});

  @override
  List<Object?> get props => [url, name];
}
