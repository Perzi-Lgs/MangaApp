import 'package:equatable/equatable.dart';

class MangaInfo extends Equatable {
  final String img; //urlimg
  final String name; //urlimg
  final String url; //urlimg

  MangaInfo(
      {required this.img,
      required this.name, required this.url});

  static final empty = MangaInfo(
    img: '',
    url: '',
    name: '',
  );

  MangaInfo copyWith({String? img, String? url, String? name}) {
    return MangaInfo(img: img ?? this.img, url: url ?? this.url, name: name ?? this.name);
  }

  @override
  List<Object?> get props => [img, url, name];
}
