import 'package:flutter/material.dart';
import '../../models/kanji.dart';

class KanjiCard extends StatefulWidget {
  final Kanji kanji;
  final VoidCallback onNext;

  const KanjiCard({
    super.key,
    required this.kanji,
    required this.onNext,
  });

  @override
  State<KanjiCard> createState() => _KanjiCardState();
}

class _KanjiCardState extends State<KanjiCard> {
  bool flipped = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!flipped)
                Text(
                  widget.kanji.character,
                  style: const TextStyle(fontSize: 96),
                )
              else ...[
                Text('Kunyomi: ${widget.kanji.kunyomi.join(", ")}'),
                Text('Onyomi: ${widget.kanji.onyomi.join(", ")}'),
                Text('Meaning: ${widget.kanji.meanings.join(", ")}'),
                Text('JLPT: ${widget.kanji.jlpt}'),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (!flipped) {
                    setState(() => flipped = true);
                  } else {
                    setState(() => flipped = false);
                    widget.onNext();
                  }
                },
                child: Text(flipped ? 'Next' : 'Flip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
