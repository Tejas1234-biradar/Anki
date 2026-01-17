import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/kanji.dart';
import 'kanji_card.dart';
import 'progress_bar.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<Kanji> today = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    _loadTodayKanji();
  }

  Future<void> _loadTodayKanji() async {
    final raw = await rootBundle.loadString('assets/kanji_n3.json');
    final List decoded = json.decode(raw);
    debugPrint('Loaded ${decoded.length} kanji');

    final all = decoded.map((e) => Kanji.fromJson(e)).toList();
    all.shuffle();

    setState(() {
      today = all.take(5).toList();
    });
  }

  void _next() {
    if (index < today.length - 1) {
      setState(() => index++);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (today.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Daily Review')),
      body: Column(
        children: [
          ProgressBar(current: index, total: today.length),
          Expanded(
            child: KanjiCard(
              kanji: today[index],
              onNext: _next,
            ),
          ),
        ],
      ),
    );
  }
}
