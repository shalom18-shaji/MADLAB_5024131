import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const PersonalNotesApp());
}

class PersonalNotesApp extends StatelessWidget {
  const PersonalNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    const forest = Color(0xFF245B4A);

    return MaterialApp(
      title: 'Personal Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: forest,
          surface: const Color(0xFFF7F8F5),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F8F5),
          foregroundColor: Color(0xFF20332B),
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFE3E9E4)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFAFBF9),
          hintStyle: const TextStyle(color: Color(0xFF8A958F)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFDCE4DE)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFDCE4DE)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: forest, width: 1.5),
          ),
        ),
      ),
      home: const NotesHomePage(),
    );
  }
}

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  final TextEditingController _noteController = TextEditingController();
  late Future<String> _noteFuture;
  String? _savedFilePath;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _noteFuture = readNote();
  }

  // Resolve the app-private documents folder and the note file path.
  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/my_notes.txt';
  }

  // Read asynchronously, returning an empty value when no note exists yet.
  Future<String> readNote() async {
    try {
      final file = File(await getFilePath());
      if (!await file.exists()) {
        return '';
      }
      return await file.readAsString();
    } catch (error) {
      throw Exception('Could not read your saved note: $error');
    }
  }

  Future<void> saveNote() async {
    setState(() => _isSaving = true);
    try {
      final path = await getFilePath();
      // writeAsString creates my_notes.txt if it does not exist yet.
      await File(path).writeAsString(_noteController.text);
      if (!mounted) return;

      setState(() {
        _savedFilePath = path;
        _noteFuture = readNote();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your note was saved successfully.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not save your note. Please try again.'),
          backgroundColor: Color(0xFF9C342D),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📝 Personal Notes'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F1EC),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.note_alt_outlined,
                            color: Color(0xFF245B4A),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Personal Notes',
                                style: textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF20332B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Write and save your thoughts',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF68756E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Write a Note',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF20332B),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _noteController,
                  minLines: 5,
                  maxLines: 9,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Type your note here...',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 50,
                  child: FilledButton.icon(
                    onPressed: _isSaving ? null : saveNote,
                    icon: _isSaving
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(_isSaving ? 'Saving...' : 'Save Note'),
                  ),
                ),
                if (_savedFilePath != null) ...[
                  const SizedBox(height: 22),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.folder_open_outlined,
                            color: Color(0xFF68756E),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Saved file',
                                  style: textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                SelectableText(
                                  _savedFilePath!,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF68756E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 28),
                Text(
                  'Saved Note',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF20332B),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: FutureBuilder<String>(
                      future: _noteFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Text(
                            'Your saved note could not be loaded. Check file access and try again.',
                            style: TextStyle(color: Color(0xFF9C342D)),
                          );
                        }
                        final note = snapshot.data ?? '';
                        if (note.isEmpty) {
                          return const Text(
                            'No saved note yet. Write a note above and save it here.',
                            style: TextStyle(color: Color(0xFF68756E)),
                          );
                        }
                        return SelectableText(
                          note,
                          style: textTheme.bodyLarge?.copyWith(height: 1.55),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Center(
                  child: Text(
                    'Made with ❤️ using Flutter',
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF7B8780),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}