import '../../domain/entities/complete_manga_info.dart';
import 'chapter_model.dart';

class CompleteMangaInfoModel extends CompleteMangaInfo {
  CompleteMangaInfoModel({
    required String img, //urlimg
    required String name, //urlimg
    required String description, //urlimg
    required String author, //urlimg
    required List<String> genre, //urlimg
    required String update, //urlimg
    required String status, //urlimg
    required List<ChapterModel> scans,
  }) : super(
            img: img,
            name: name,
            description: description,
            author: author,
            genre: genre,
            update: update,
            scans: scans,
            status: status);

  factory CompleteMangaInfoModel.fromJson(Map<String, dynamic> json) {
    print(json);
    List<ChapterModel> _chapters =
        (json['scans'] as List).map((e) => ChapterModel.fromJson(e)).toList();

    return CompleteMangaInfoModel(
      img: json['img'] ?? '',
      name: json['name'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      genre: List.from(json['genre']),
      scans: _chapters,
      update: json['update'] ?? '',
      status: json['status'] ?? '',
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
      'status': status,
    };
  }
}
