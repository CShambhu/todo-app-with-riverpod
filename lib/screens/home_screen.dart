import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/provider/notes_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(title: Text("TODO APP")),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          return ListTile(
            onTap: () => _showEditNoteDialog(context, ref, note),
            title: Text(note.title, style: TextStyle(fontSize: 22)),
            subtitle: Text(note.content),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                ref.read(notesProvider.notifier).deleteNote(note.id);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Note deleted'),
                    duration: Duration(seconds: 3),
                  ),
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showAddNoteDialog(BuildContext context, WidgetRef ref) {
  final titleEditingController = TextEditingController();
  final contentEditingController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Add Note"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleEditingController,
            decoration: InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: contentEditingController,
            decoration: InputDecoration(
              labelText: "Content",
              alignLabelWithHint: true,
            ),
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: 3,
            maxLines: null,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (titleEditingController.text.trim().isEmpty) return;
            ref
                .read(notesProvider.notifier)
                .addNote(
                  titleEditingController.text.trim(),
                  contentEditingController.text.trim(),
                );
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
}

void _showEditNoteDialog(BuildContext context, WidgetRef ref, Note note) {
  final titleController = TextEditingController(text: note.title);
  final contentController = TextEditingController(text: note.content);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Edit Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: contentController,
            decoration: const InputDecoration(labelText: 'Content'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (titleController.text.trim().isEmpty) return;
            ref
                .read(notesProvider.notifier)
                .updateNote(
                  note.id,
                  titleController.text.trim(),
                  contentController.text.trim(),
                );
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
