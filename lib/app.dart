import 'package:flutter/material.dart';
import 'features/review/review_screen.dart';
import 'features/lookup/lookup_screen.dart';
import 'core/theme.dart';

class AnkiKanjiApp extends StatelessWidget {
  const AnkiKanjiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anki Kanji',
      theme: appTheme,
      routes: {
        '/': (_) => const ReviewScreen(),
        // '/lookup': (_) => const LookupScreen(),
      },
    );
  }
}
