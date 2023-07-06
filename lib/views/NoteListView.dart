import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../models/note.dart';
import '../viewsmodels/note_view_model.dart';

class NoteListView extends StatelessWidget {
  final NoteViewModel viewModel = NoteViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Not Defteri Uygulaması',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
      body: BlocBuilder<NoteViewModel, List<Note>>(
        bloc: viewModel,
        builder: (context, notes) {
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(notes[index].title),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  viewModel.deleteNote(index);
                },
                child: Card(
                  elevation: 8,
                  child: ListTile(
                    title: Text(notes[index].title),
                    subtitle: Text(notes[index].content),
                    onTap: () {
                      _editNote(context, notes[index], index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          _addNote(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String content = '';

        return AlertDialog(
          title: Text('Not Ekle'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Başlık',
                ),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'İçerik',
                ),
                onChanged: (value) {
                  content = value;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Note note = Note(
                  title: title,
                  content: content,
                );
                viewModel.addNote(note);
                Navigator.of(context).pop();
              },
              child: Text('Ekle'),
            ),
          ],
        );
      },
    );
  }

  void _editNote(BuildContext context, Note note, int index) {
    showDialog(
      context: context,
      builder: (context) {
        String title = note.title;
        String content = note.content;

        return AlertDialog(
          title: Text('Notu Düzenle'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Başlık',
                ),
                onChanged: (value) {
                  title = value;
                },
                controller: TextEditingController(text: title),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'İçerik',
                ),
                onChanged: (value) {
                  content = value;
                },
                controller: TextEditingController(text: content),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Note updatedNote = Note(
                  title: title,
                  content: content,
                );
                viewModel.updateNote(index, updatedNote);
                Navigator.of(context).pop();
              },
              child: Text('Güncelle'),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.deleteNote(index);
                Navigator.of(context).pop();
              },
              child: Text('Sil'),
            ),
          ],
        );
      },
    );
  }
}
