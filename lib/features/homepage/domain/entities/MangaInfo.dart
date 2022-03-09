import 'package:equatable/equatable.dart';

class MangaInfo extends Equatable {
  final String img; //urlimg
  final String name; //urlimg
  final String url; //urlimg
  final String author; //urlimg

  MangaInfo(
      {required this.img,
      required this.name,
      required this.url,
      required this.author});

  static final empty = MangaInfo(
    img: '',
    url: '',
    name: '',
    author: '',
  );

  MangaInfo copyWith({String? img, String? url, String? name, String? author}) {
    return MangaInfo(
        img: img ?? this.img,
        url: url ?? this.url,
        name: name ?? this.name,
        author: author ?? this.author);
  }

  @override
  List<Object?> get props => [img, url, name];
}
