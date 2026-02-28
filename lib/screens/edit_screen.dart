import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import '../models/note_service.dart';

// Application bar title constant (same as home screen).
// Student identification included per requirements.
const String kAppBarTitle = 'Smart Note - Phan Thị Sông Thương - 2351160557';

class EditScreen extends StatefulWidget {
  final NoteService noteService;
  final Note? note; // null if creating new note

  const EditScreen({required this.noteService, this.note, super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _tagsController;
  late Note _currentNote;
  bool _hasChanges = false;

  final List<Color> _availableColors = [
    Colors.white,
    Colors.red[100]!,
    Colors.orange[100]!,
    Colors.yellow[100]!,
    Colors.green[100]!,
    Colors.blue[100]!,
    Colors.purple[100]!,
    Colors.pink[100]!,
  ];

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _currentNote = widget.note!;
      _titleController = TextEditingController(text: _currentNote.title);
      _contentController = TextEditingController(text: _currentNote.content);
      _tagsController = TextEditingController(
        text: _currentNote.tags.join(', '),
      );
    } else {
      _currentNote = Note(
        id: const Uuid().v4(),
        title: '',
        content: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _titleController = TextEditingController();
      _contentController = TextEditingController();
      _tagsController = TextEditingController();
    }

    _titleController.addListener(() => _onContentChanged());
    _contentController.addListener(() => _onContentChanged());
    _tagsController.addListener(() => _onContentChanged());
  }

  void _onContentChanged() {
    _hasChanges = true;
  }

  Future<void> _saveNote() async {
    final tags = _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    final updatedNote = _currentNote.copyWith(
      title: _titleController.text,
      content: _contentController.text,
      updatedAt: DateTime.now(),
      tags: tags,
    );

    if (widget.note != null) {
      // Update existing note
      await widget.noteService.updateNote(updatedNote);
    } else {
      // Add new note
      await widget.noteService.addNote(updatedNote);
    }

    _hasChanges = false;
  }

  Future<bool> _onWillPop() async {
    if (_hasChanges) {
      await _saveNote();
    }
    if (!mounted) return true;
    Navigator.of(context).pop(true);
    return false;
  }

  void _changeColor(Color color) {
    setState(() {
      final int r = (color.r * 255.0).round().clamp(0, 255);
      final int g = (color.g * 255.0).round().clamp(0, 255);
      final int b = (color.b * 255.0).round().clamp(0, 255);
      String hexColor =
          '#'
                  '${r.toRadixString(16).padLeft(2, '0')}'
                  '${g.toRadixString(16).padLeft(2, '0')}'
                  '${b.toRadixString(16).padLeft(2, '0')}'
              .toUpperCase();
      _currentNote = _currentNote.copyWith(color: hexColor);
      _onContentChanged();
    });
  }

  void _togglePin() {
    setState(() {
      _currentNote = _currentNote.copyWith(isPinned: !_currentNote.isPinned);
      _onContentChanged();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color currentColor = _parseColor(_currentNote.color);

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(kAppBarTitle),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _onWillPop,
          ),
          actions: [
            IconButton(
              icon: Icon(
                _currentNote.isPinned
                    ? Icons.push_pin
                    : Icons.push_pin_outlined,
                color: _currentNote.isPinned ? Colors.orange : Colors.white,
              ),
              onPressed: _togglePin,
            ),
          ],
        ),
        backgroundColor: currentColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Input
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Tiêu đề ghi chú',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey[300]),
                const SizedBox(height: 16),
                // Content Input
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: 'Nhập nội dung ghi chú...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(fontSize: 16, height: 1.5),
                  maxLines: null,
                ),
                const SizedBox(height: 24),
                // Tags Input
                TextField(
                  controller: _tagsController,
                  decoration: InputDecoration(
                    hintText: 'Tags (phân cách bằng dấu phẩy)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.label),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                // Color Picker
                Text(
                  'Chọn màu:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _availableColors.map((color) {
                    bool isSelected = color == currentColor;
                    return GestureDetector(
                      onTap: () => _changeColor(color),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: color,
                          border: isSelected
                              ? Border.all(color: Colors.black, width: 3)
                              : Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.black)
                            : null,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
    } catch (e) {
      return Colors.white;
    }
  }
}
