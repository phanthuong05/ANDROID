import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'note.dart';

class NoteService {
  static const String _notesKey = 'notes';
  late SharedPreferences _prefs;

  // Initialize the service
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get all notes
  Future<List<Note>> getAllNotes() async {
    try {
      final jsonString = _prefs.getString(_notesKey);
      if (jsonString == null) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => Note.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error loading notes: $e');
      return [];
    }
  }

  // Get a single note by ID
  Future<Note?> getNoteById(String id) async {
    final notes = await getAllNotes();
    try {
      return notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  // Add a new note
  Future<void> addNote(Note note) async {
    try {
      final notes = await getAllNotes();
      notes.add(note);
      await _saveNotes(notes);
    } catch (e) {
      debugPrint('Error adding note: $e');
    }
  }

  // Update an existing note
  Future<void> updateNote(Note updatedNote) async {
    try {
      final notes = await getAllNotes();
      final index = notes.indexWhere((note) => note.id == updatedNote.id);
      if (index != -1) {
        notes[index] = updatedNote;
        await _saveNotes(notes);
      }
    } catch (e) {
      debugPrint('Error updating note: $e');
    }
  }

  // Delete a note
  Future<void> deleteNote(String id) async {
    try {
      final notes = await getAllNotes();
      notes.removeWhere((note) => note.id == id);
      await _saveNotes(notes);
    } catch (e) {
      debugPrint('Error deleting note: $e');
    }
  }

  // Save notes to SharedPreferences
  Future<void> _saveNotes(List<Note> notes) async {
    try {
      final jsonList = notes.map((note) => note.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await _prefs.setString(_notesKey, jsonString);
    } catch (e) {
      debugPrint('Error saving notes: $e');
    }
  }

  // Clear all notes
  Future<void> clearAll() async {
    try {
      await _prefs.remove(_notesKey);
    } catch (e) {
      debugPrint('Error clearing notes: $e');
    }
  }
}
