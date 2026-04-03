import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fe_note_app/domain/models/note_model.dart';

class NoteApi {
  // Lấy danh sách ghi chú
  Future<List<Note>> fetchNotes() async {
    final res = await http.get(Uri.parse('http://10.0.2.2:3000/api/notes/get'));

    if (res.statusCode == 200) {
      List jsonResponse = json.decode(res.body);
      return jsonResponse.map((e) => Note.fromJson(e)).toList();
    } else {
      throw Exception('Không thể tải ghi chú');
    }
  }

  // Tạo ghi chú mới
  Future<void> createNote({String title = '', String content = ''}) async {
    final res = await http.post(
      Uri.parse('http://10.0.2.2:3000/api/notes/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'content': content}),
    );

    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception("Create failed: ${res.statusCode}");
    }
  }

  // Cập nhật ghi chú
  Future<void> updateNote(String id, String title, String content) async {

    final res = await http.put(
      Uri.parse('http://10.0.2.2:3000/api/notes/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'content': content}),
    );

    if (res.statusCode != 200) {
      throw Exception("Update failed: ${res.statusCode}");
    }
  }

  // Xóa ghi chú theo tiêu đề
  Future<void> deleteNote(String id) async {
    final res = await http.delete(
      Uri.parse('http://10.0.2.2:3000/api/notes/delete/$id'),
    );

    if (res.statusCode != 200) {
      throw Exception("Delete failed");
    }
  }

  Future<List<Note>> searchNotes(String query) async {
    final res = await http.get(
      // 2. Dùng query parameter (?q=) để Backend dễ xử lý
      Uri.parse('http://10.0.2.2:3000/api/notes/search?q=$query'),
    );

    if (res.statusCode == 200) {
      // 3. Giải mã JSON và chuyển thành danh sách các đối tượng Note
      List<dynamic> body = json.decode(res.body);
      return body.map((item) => Note.fromJson(item)).toList();
    } 
    else {
      throw Exception('Không thể tải ghi chú');
    }
  }
}