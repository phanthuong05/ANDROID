import 'package:flutter/material.dart';
import 'models/note_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize NoteService
  final noteService = NoteService();
  await noteService.init();

  runApp(MainApp(noteService: noteService));
}

class MainApp extends StatefulWidget {
  final NoteService noteService;

  const MainApp({required this.noteService, super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Note',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(
        noteService: widget.noteService,
        onThemeModeChanged: (isDark) {
          setState(() {
            _isDarkMode = isDark;
          });
        },
        isDarkMode: _isDarkMode,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
