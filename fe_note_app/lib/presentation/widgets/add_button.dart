import 'package:flutter/material.dart';
import 'package:fe_note_app/presentation/screens/note_detail.dart';
import 'package:fe_note_app/core/responsive.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onNoteAdded;

  const AddButton({super.key, required this.onNoteAdded});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NoteDetailScreen()),
        );

        if (!context.mounted) return;

        if (result == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Tạo ghi chú thành công")),
          );
          onNoteAdded();
        }
      },

      mini: !Responsive.isMobile(context),

      child: Icon(Icons.add, size: Responsive.isMobile(context) ? 28 : 20),
    );
  }
}
