import '../../domain/entities/MangaLink.dart';

class LinkModel extends MangaLink {
  LinkModel({
    required String url,
    required String name,
  }) : super(url: url, name: name);

  factory LinkModel.fromJson(Map<String, dynamic> json) {
    return LinkModel(url: json['url'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {"url": url, "name": name};
  }
}
