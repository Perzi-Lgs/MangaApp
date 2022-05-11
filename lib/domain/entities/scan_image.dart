import 'package:equatable/equatable.dart';

class ScanImage extends Equatable {
  final String name;
  final String imageLink;

  ScanImage({required this.name, required this.imageLink});

  static final empty = ScanImage(imageLink: '', name: '');

  ScanImage copyWith({
    String? name,
    String? imageLink,
  }) {
    return ScanImage(
      imageLink: imageLink ?? this.imageLink,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [name, imageLink];
}
