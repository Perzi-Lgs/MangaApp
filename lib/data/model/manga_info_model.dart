import '../../domain/entities/manga_info.dart';
import '../../domain/entities/searchableField.dart';

class MangaInfoModel extends MangaInfo {
  MangaInfoModel({
    required String img,
    required String url,
    required String name,
    required SearchableField author,
  }) : super(img: img, url: url, name: name, author: author);

  factory MangaInfoModel.fromJson(Map<String, dynamic> json) {
    return MangaInfoModel(
      url: json['url'],
      img: json['img'],
      name: json['name'],
      author: SearchableField.fromJson(json['author'] ?? SearchableField.empty()),

    );
  }

  Map<String, dynamic> toJson() {
    return {'img': img, 'name': name, 'url': url};
  }
}
