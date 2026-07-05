class Note {
  final String id;
  final String title;
  final String content;
  final bool isFavorite;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.isFavorite = false,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    bool? isFavorite,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
