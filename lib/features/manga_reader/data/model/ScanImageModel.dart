import '../../domain/entities/ScanImage.dart';

class ScanImageModel extends ScanImage {
  ScanImageModel({required String name, required String imageLink})
      : super(name: name, imageLink: imageLink);

  ScanImageModel copyWith({String? name, String? imageLink}) {
    return ScanImageModel(
        name: name ?? this.name, imageLink: imageLink ?? this.imageLink);
  }

  static final empty = ScanImageModel(name: '', imageLink: '');

  factory ScanImageModel.fromJson(Map<String, dynamic> json) {
    return ScanImageModel(name: json['name'], imageLink: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': imageLink};
  }

  @override
  List<Object?> get props => [name, imageLink];
}
