import 'package:mobile/features/manga_info_page/domain/entities/Chapter.dart';

class ChapterModel extends Chapter {
  ChapterModel({required name, required url}) : super(name: name, url: url);

  ChapterModel copyWith({String? name, String? url}) {
    return ChapterModel(name: name ?? this.name, url: url ?? this.url);
  }

  static final empty = ChapterModel(name: '', url: '');

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }

  @override
  List<Object?> get props => [name, url];
}
