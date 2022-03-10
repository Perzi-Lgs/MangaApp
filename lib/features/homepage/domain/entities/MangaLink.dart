import 'package:equatable/equatable.dart';

class MangaLink extends Equatable {
  final String url;
  final String name;

  MangaLink({required this.url, required this.name});

  static final empty = MangaLink(
    url: '',
    name: ''
  );

  MangaLink copyWith({
    String? url,
    String? name,
  }) {
    return MangaLink(name: name?? this.name, url: url ?? this.url);
  }

  @override
  List<Object?> get props => [url, name];
}
