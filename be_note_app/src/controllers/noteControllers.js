const Note = require('../models/note');

//  Lấy tất cả ghi chú
exports.getAllNotes = async (req, res) => {
  try {
    const notes = await Note.find().sort({ createdAt: -1 });

    res.json(notes);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

//  Tạo ghi chú
exports.createNote = async (req, res) => {
  try {
    const { title, content } = req.body;

    const newNote = new Note({ title, content });
    const saved = await newNote.save();

    res.status(201).json(saved);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};
//  Cập nhật ghi chú
exports.updateNote = async (req, res) => {
  try {
    const { title, content } = req.body;


    const updatedNote = await Note.findByIdAndUpdate(
      req.params.id,
      { title, content },
      { new: true, runValidators: true }
    );

    if (!updatedNote) {
      return res.status(404).json({ message: 'Không tìm thấy ghi chú' });
    }

    res.json(updatedNote);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

//  Xóa ghi chú
exports.deleteNote = async (req, res) => {
  try {
    await Note.findByIdAndDelete(req.params.id);

    res.json({ message: 'Deleted successfully' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

exports.searchNotes = async (req, res) => {
  try {
    const result = req.query.q;
    const notes = await Note.find({ title: { $regex: `^${result}`, $options: 'i' } }).sort({ createdAt: 1 });
    res.json(notes);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
}