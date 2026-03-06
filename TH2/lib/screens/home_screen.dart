import 'package:flutter/material.dart';
import '../models/note.dart';
import '../models/note_service.dart';
import 'edit_screen.dart';

// AppBar title including student identification as required by assignment.
const String kAppBarTitle = 'Smart Note - Phan Thị Sông Thương - 2351160557';

class HomeScreen extends StatefulWidget {
  final NoteService noteService;
  final Function(bool) onThemeModeChanged;
  final bool isDarkMode;

  const HomeScreen({
    required this.noteService,
    required this.onThemeModeChanged,
    required this.isDarkMode,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  bool _isLoading = true;
  String _sortBy = 'date'; // date, title, color
  final Set<String> _selectedTags = {};

  @override
  void initState() {
    super.initState();
    _loadNotes();
    _searchController.addListener(_filterNotes);
  }

  Future<void> _loadNotes() async {
    setState(() {
      _isLoading = true;
    });
    final notes = await widget.noteService.getAllNotes();
    _sortNotes(notes);
    setState(() {
      _notes = notes;
      _filteredNotes = notes;
      _isLoading = false;
    });
  }

  void _sortNotes(List<Note> notes) {
    if (_sortBy == 'date') {
      notes.sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return b.isPinned ? 1 : -1; // Pinned first
        }
        return b.updatedAt.compareTo(a.updatedAt);
      });
    } else if (_sortBy == 'title') {
      notes.sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return b.isPinned ? 1 : -1;
        }
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      });
    } else if (_sortBy == 'color') {
      notes.sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return b.isPinned ? 1 : -1;
        }
        return a.color.compareTo(b.color);
      });
    }
  }

  void _filterNotes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredNotes = _notes.where((note) {
        // Per requirement: filter only by title (real-time)
        final matchesSearch = note.title.toLowerCase().contains(query);
        final matchesTags =
            _selectedTags.isEmpty ||
            _selectedTags.every((tag) => note.tags.contains(tag));
        return matchesSearch && matchesTags;
      }).toList();
    });
  }

  void _goToEditScreen({Note? note}) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) =>
            EditScreen(noteService: widget.noteService, note: note),
      ),
    );
    if (result == true) {
      _loadNotes();
    }
  }

  void _togglePin(Note note) async {
    final updatedNote = note.copyWith(isPinned: !note.isPinned);
    await widget.noteService.updateNote(updatedNote);
    _loadNotes();
  }

  // Deletion is handled inline via Dismissible.confirmDismiss.

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          kAppBarTitle,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => widget.onThemeModeChanged(!widget.isDarkMode),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm ghi chú...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          // Filter and Sort Options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                // Sort dropdown
                Expanded(
                  child: DropdownButton<String>(
                    value: _sortBy,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: 'date',
                        child: Text('Sắp xếp: Ngày'),
                      ),
                      DropdownMenuItem(
                        value: 'title',
                        child: Text('Sắp xếp: Tên'),
                      ),
                      DropdownMenuItem(
                        value: 'color',
                        child: Text('Sắp xếp: Màu'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _sortBy = value ?? 'date';
                        _sortNotes(_notes);
                        _filterNotes();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                // Filter by tags
                ElevatedButton.icon(
                  onPressed: _showTagsFilter,
                  icon: const Icon(Icons.label),
                  label: Text(
                    'Tags${_selectedTags.isNotEmpty ? '(${_selectedTags.length})' : ''}',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Notes Grid or Empty State
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredNotes.isEmpty
                ? _buildEmptyState()
                : _buildNotesGrid(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToEditScreen(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showTagsFilter() {
    Set<String> allTags = {};
    for (var note in _notes) {
      allTags.addAll(note.tags);
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: const Text('Lọc theo Tags'),
          content: allTags.isEmpty
              ? const Text('Không có tags nào')
              : SingleChildScrollView(
                  child: Column(
                    children: allTags.map((tag) {
                      return CheckboxListTile(
                        title: Text(tag),
                        value: _selectedTags.contains(tag),
                        onChanged: (value) {
                          setStateDialog(() {
                            if (value == true) {
                              _selectedTags.add(tag);
                            } else {
                              _selectedTags.remove(tag);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _filterNotes();
                });
              },
              child: const Text('Áp dụng'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isEmpty && _selectedTags.isEmpty
                ? 'Bạn chưa có ghi chú nào, hãy tạo mới nhé!'
                : 'Không tìm thấy ghi chú phù hợp',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _filteredNotes.length,
      itemBuilder: (context, index) {
        final note = _filteredNotes[index];
        return _buildNoteCard(note);
      },
    );
  }

  Widget _buildNoteCard(Note note) {
    Color noteColor = _parseColor(note.color);

    return Dismissible(
      key: Key(note.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        await widget.noteService.deleteNote(note.id);
        _loadNotes();
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Ghi chú đã được xóa')));
        }
      },
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Xác nhận xóa'),
            content: const Text('Bạn có chắc chắn muốn xóa ghi chú này không?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Xóa', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () => _goToEditScreen(note: note),
        onLongPress: () => _togglePin(note),
        child: Card(
          color: noteColor,
          shadowColor: Colors.black26,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with Pin Icon
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        note.title.isEmpty ? '(Untitled)' : note.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (note.isPinned)
                      const Icon(
                        Icons.push_pin,
                        size: 16,
                        color: Colors.orange,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                // Content Preview
                Text(
                  note.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                // Tags
                if (note.tags.isNotEmpty)
                  Wrap(
                    spacing: 4,
                    children: note.tags
                        .take(2)
                        .map(
                          (tag) => Chip(
                            label: Text(
                              tag,
                              style: const TextStyle(fontSize: 10),
                            ),
                            padding: const EdgeInsets.all(0),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 4),
                // Timestamp
                Text(
                  _formatDateTime(note.updatedAt),
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
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

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }
}
