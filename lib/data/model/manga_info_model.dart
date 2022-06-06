import '../../domain/entities/authorData.dart';
import '../../domain/entities/manga_info.dart';

class MangaInfoModel extends MangaInfo {
  MangaInfoModel({
    required String img,
    required String url,
    required String name,
    required Author author,
  }) : super(img: img, url: url, name: name, author: author);

  factory MangaInfoModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return MangaInfoModel(
      url: json['url'] ?? '',
      img: json['img'] ?? '',
      name: json['name'] ?? '', author: Author.fromJson(json['author'] ?? Author.empty()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'img': img, 'name': name, 'url': url, 'author': {'label': author.label}};
  }
}
