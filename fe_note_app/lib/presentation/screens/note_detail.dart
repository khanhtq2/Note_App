import 'package:flutter/material.dart';
import 'package:fe_note_app/domain/models/note_model.dart';
import 'package:fe_note_app/data/datasources/note_api.dart';
import 'package:fe_note_app/core/responsive.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;

  const NoteDetailScreen({super.key, this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  final NoteApi api = NoteApi();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? "");
    contentController = TextEditingController(text: widget.note?.content ?? "");
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.note != null;
    double width = Responsive.width(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Chi tiết ghi chú" : "Thêm ghi chú mới"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              final navigator = Navigator.of(context);

              if (isEdit) {
                await api.updateNote(
                  widget.note!.id,
                  titleController.text,
                  contentController.text,
                );
              } else {
                await api.createNote(
                  title: titleController.text,
                  content: contentController.text,
                );
              }

              navigator.pop(true);
            },
          ),
          if (isEdit)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final navigator = Navigator.of(context);

                bool confirmDelete =
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Xác nhận xóa ghi chú"),
                          content: const Text(
                            "Bạn có muốn xóa ghi chú này không?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Hủy"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Xóa"),
                            ),
                          ],
                        );
                      },
                    ) ??
                    false;

                if (!confirmDelete) return;

                try {
                  await api.deleteNote(widget.note!.id);

                  if (!navigator.context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Xóa thành công")),
                  );

                  navigator.pop(true);
                } catch (e) {
                  if (!navigator.context.mounted) return;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Lỗi: $e")));
                }
              },
            ),
        ],
      ),

    
      body: Center(
        child: Container(
          width: Responsive.isDesktop(context) ? 700 : double.infinity, 
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 16),

          child: Column(
            children: [
          
              TextField(
                controller: titleController,
                style: TextStyle(
                  fontSize: width * 0.05, 
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: "Tiêu đề",
                  border: InputBorder.none,
                ),
              ),

              const Divider(),

              const SizedBox(height: 10),

              
              Expanded(
                child: TextField(
                  controller: contentController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(fontSize: width * 0.04),
                  decoration: const InputDecoration(
                    hintText: "Nhập nội dung ghi chú...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
