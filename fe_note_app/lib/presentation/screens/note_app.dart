import 'package:flutter/material.dart';
import 'package:fe_note_app/presentation/widgets/search_bar.dart';
import 'package:fe_note_app/presentation/widgets/theme_toggle_button.dart';
import 'package:fe_note_app/presentation/widgets/add_button.dart';
import 'package:fe_note_app/presentation/widgets/card_note.dart';
import 'package:fe_note_app/core/responsive.dart';

class NoteApp extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const NoteApp({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  String searchQuery = '';
  Key cardNoteKey = UniqueKey();

  void refreshNotes() {
    setState(() {
      cardNoteKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = Responsive.width(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Note App',
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 24 : 20, 
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          ThemeToggleButton(
            isDarkMode: widget.isDarkMode,
            onToggle: widget.onToggleTheme,
          ),
        ],
      ),

      
      body: Center(
        child: SizedBox(
         width: Responsive.isDesktop(context) ? 800 : double.infinity,
          child: Column(
            children: [
              CustomSearchBar(
                onSearch: (value) {
                  setState(() {
                    searchQuery = value;
                    cardNoteKey = UniqueKey();
                  });
                },
              ),

              Expanded(
                child: CardNote(
                  key: cardNoteKey,
                  searchQuery: searchQuery,
                  isGrid: !Responsive.isMobile(context),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: width * 0.05, 
                  bottom: 30,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AddButton(onNoteAdded: refreshNotes),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}