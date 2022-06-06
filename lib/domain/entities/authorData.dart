class Author {
  final String label;

  const Author({required this.label});

  Author copyWith({String? label}) {
    return Author(label: label ?? this.label);
  }

  static Author empty() {
    return Author(label: '');
  }

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(label: json['label'] ?? '');
  }
}