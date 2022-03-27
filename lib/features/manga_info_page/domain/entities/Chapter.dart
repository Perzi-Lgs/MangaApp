import 'package:equatable/equatable.dart';

class Chapter extends Equatable {
  final String name;
  final String url;

  Chapter({required this.name, required this.url});

  Chapter copyWith({String? name, String? url}) {
    return Chapter(name: name ?? this.name, url: url ?? this.url);
  }

  static final empty = Chapter(name: '', url: '');

  @override
  List<Object?> get props => [name, url];
}