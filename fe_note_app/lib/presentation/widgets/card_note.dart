import 'package:flutter/material.dart';
import 'package:fe_note_app/data/datasources/note_api.dart';
import 'package:fe_note_app/domain/models/note_model.dart';
import 'package:fe_note_app/presentation/screens/note_detail.dart';
import 'package:fe_note_app/core/responsive.dart';

class CardNote extends StatefulWidget {
  final String searchQuery;
  final bool isGrid;

  const CardNote({super.key, required this.searchQuery, this.isGrid = false});

  @override
  State<CardNote> createState() => _CardNoteState();
}

class _CardNoteState extends State<CardNote> {
  final NoteApi api = NoteApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Note>>(
      future: widget.searchQuery.isEmpty
          ? api.fetchNotes()
          : api.searchNotes(widget.searchQuery),
      builder: (context, snapshot) {
        // LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // ERROR
        if (snapshot.hasError) {
          return Center(child: Text("Lỗi: ${snapshot.error}"));
        }

        final notes = snapshot.data ?? [];

        // EMPTY
        if (notes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.note_alt_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.searchQuery.isEmpty
                      ? "Bạn chưa có ghi chú nào"
                      : "Không tìm thấy ghi chú phù hợp",
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          );
        }

        if (widget.isGrid) {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context)
                  ? 4
                  : Responsive.isTablet(context)
                  ? 3
                  : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3,
            ),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return _buildCard(note);
            },
          );
        } else {
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: _buildCard(note),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildCard(Note note) {
    return Card(
      child: ListTile(
        title: Text(
          note.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          note.content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NoteDetailScreen(note: note)),
          );

          if (!mounted) return;

          if (result == true) {
            setState(() {});
          }
        },
      ),
    );
  }
}
