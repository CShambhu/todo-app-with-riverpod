import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/model/todo_model.dart';

part 'notes_provider.g.dart';

@riverpod
class Notes extends _$Notes {
  @override
  List<Note> build() {
    return [];
  }

  void addNote(String title, String content) {
    final newNote = Note(
      id: DateTime.now().toString(),
      title: title,
      content: content,
    );
    state = [...state, newNote];
  }

  void updateNote(String id, String newTitle, String newContent) {
    state = state.map((note) {
      if (note.id == id) {
        return note.copyWith(title: newTitle, content: newContent);
      }
      return note;
    }).toList();
  }

  void deleteNote(String id) {
    state = state.where((note) => note.id != id).toList();
  }
}
