import 'package:mobile/features/manga_info_page/data/model/Chapter_model.dart';

import '../../domain/entities/Chapter.dart';
import '../../domain/entities/CompleteMangaInfo.dart';

class CompleteMangaInfoModel extends CompleteMangaInfo {
  CompleteMangaInfoModel({
    required String img, //urlimg
    required String name, //urlimg
    required String description, //urlimg
    required String author, //urlimg
    required List<String> genre, //urlimg
    required String update, //urlimg
    required List<ChapterModel> scans,
  }) : super(
            img: img,
            name: name,
            description: description,
            author: author,
            genre: genre,
            update: update,
            scans: scans);

  factory CompleteMangaInfoModel.fromJson(Map<String, dynamic> json) {
    List<ChapterModel> _chapters =
        (json['scans'] as List).map((e) => ChapterModel.fromJson(e)).toList();

    print(_chapters);
    return CompleteMangaInfoModel(
      img: json['img'],
      name: json['name'],
      author: json['author'],
      description: json['description'],
      genre: json['genre'],
      scans: _chapters,
      update: json['update'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'name': name,
      'author': author,
      'description': description,
      'genre': genre.toString(),
      'update': update,
    };
  }
}
