class SearchableField {
  final String label;
  final String id;

  const SearchableField( {required this.label, this.id = ''});

  SearchableField copyWith({String? label, String? id}) {
    return SearchableField(label: label ?? this.label, id: id ?? this.id);
  }

  static SearchableField empty() {
    return SearchableField(label: '');
  }

  factory SearchableField.fromJson(Map<String, dynamic> json) {
    return SearchableField(label: json['label'] ?? '', id: json['id'] ?? '');
  }
}