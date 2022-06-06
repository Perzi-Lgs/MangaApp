import 'package:equatable/equatable.dart';
import 'package:mobile/domain/entities/authorData.dart';

class MangaInfo extends Equatable {
  final String img; //urlimg
  final String name; //urlimg
  final String url; //urlimg
  final Author author; //urlimg

  MangaInfo( 
      {required this.author, required this.img,
      required this.name, required this.url});

  static final empty = MangaInfo(
    img: '',
    url: '',
    name: '', author: Author.empty(),
  );

  MangaInfo copyWith({String? img, String? url, String? name, Author? author}) {
    return MangaInfo(img: img ?? this.img, url: url ?? this.url, name: name ?? this.name, author: author ?? this.author);
  }

  @override
  List<Object?> get props => [img, url, name, author];
}
