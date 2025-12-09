import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widget/custom_app_bar.dart';

class ScreenC extends StatefulWidget {
  final String initialPhrase;
  final String initialHashtags;

  const ScreenC({
    super.key,
    required this.initialPhrase,
    required this.initialHashtags,
  });

  @override
  State<ScreenC> createState() => _ScreenCState();
}

class _ScreenCState extends State<ScreenC> {
  late TextEditingController phraseCtrl;
  late TextEditingController tagsCtrl;
  late FocusNode phraseFocusNode;
  late FocusNode tagsFocusNode;

  @override
  void initState() {
    super.initState();
    phraseCtrl = TextEditingController(text: widget.initialPhrase);
    tagsCtrl = TextEditingController(text: widget.initialHashtags);
    phraseFocusNode = FocusNode();
    tagsFocusNode = FocusNode();

    phraseCtrl.addListener(_extractHashtags);
  }

  void _extractHashtags() {
    final text = phraseCtrl.text;
    final tags = RegExp(r'\B#\w+')
        .allMatches(text)
        .map((m) => m.group(0)!)
        .toSet()
        .join(' ');

    if (tags != tagsCtrl.text) {
      tagsCtrl.text = tags;
    }
  }

  List<TextSpan> _buildHighlightedText(String text) {
    final regex = RegExp(r'\B#\w+');
    final spans = <TextSpan>[];
    int start = 0;

    for (var match in regex.allMatches(text)) {
      if (match.start > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, match.start),
            style: const TextStyle(color: Colors.black),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: match.group(0),
          style: TextStyle(
            color: Colors.blue[700],
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.blue[50],
          ),
        ),
      );
      start = match.end;
    }

    if (start < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(start),
          style: const TextStyle(color: Colors.black),
        ),
      );
    }

    return spans;
  }

  @override
  void dispose() {
    phraseCtrl.dispose();
    tagsCtrl.dispose();
    phraseFocusNode.dispose();
    tagsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Create Content'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Preview Card
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.visibility, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Live Preview',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      phraseCtrl.text.isEmpty
                          ? const Text(
                        'Type something to see preview...',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                          : RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 15),
                          children: _buildHighlightedText(phraseCtrl.text),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Phrase Input
              const Text(
                'Phrase',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: phraseCtrl,
                  focusNode: phraseFocusNode,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Type your phrase here... (Use #hashtags)',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 24),

              // Hashtags Input
              const Text(
                'Hashtags',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: tagsCtrl,
                  focusNode: tagsFocusNode,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Auto-populated hashtags from phrase',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Tip: Hashtags are automatically extracted from your phrase. You can also edit them manually here.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: () {
                  context.goNamed(
                    'screenB',
                    extra: {
                      'phrase': phraseCtrl.text,
                      'hashtags': tagsCtrl.text,
                    },
                  );
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}