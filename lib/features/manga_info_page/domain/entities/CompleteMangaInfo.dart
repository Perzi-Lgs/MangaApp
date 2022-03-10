import 'package:equatable/equatable.dart';

import 'Chapter.dart';

class CompleteMangaInfo extends Equatable {
  final String img; //urlimg
  final String name; //urlimg
  final String description; //urlimg
  final String author; //urlimg
  final List<String> genre; //urlimg
  final String update; //urlimg
  final List<Chapter> scans; //urlimg

  CompleteMangaInfo(
      {required this.img,
      required this.name,
      required this.description,
      required this.author,
      required this.genre,
      required this.update,
      required this.scans, url});

  static final empty = CompleteMangaInfo(
    img: '',
    name: '',
    author: '',
    description: '',
    genre: [],
    scans: [],
    update: '',
  );

  CompleteMangaInfo copyWith({
    String? img,
    String? name,
    String? description,
    String? author,
    List<String>? genre,
    String? update,
    List<Chapter>? scans,
  }) {
    return CompleteMangaInfo(
        img: img ?? this.img,
        name: name ?? this.name,
        author: author ?? this.author,
        description: description ?? this.description,
        genre: genre ?? this.genre,
        scans: scans ?? this.scans,
        update: update ?? this.update);
  }

  @override
  List<Object?> get props => [
        img,
        name,
        author,
        description,
        genre,
        scans,
        update,
      ];
}
