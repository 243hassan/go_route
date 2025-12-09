import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widget/custom_app_bar.dart';

class ScreenB extends StatelessWidget {
  final String phrase;
  final String hashtags;

  const ScreenB({
    super.key,
    required this.phrase,
    required this.hashtags,
  });

  List<TextSpan> highlightHashtags(String text) {
    final regex = RegExp(r'\B#\w+');
    final spans = <TextSpan>[];
    int start = 0;

    for (var match in regex.allMatches(text)) {
      if (match.start > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, match.start),
            style: const TextStyle(color: Colors.black87),
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
          style: const TextStyle(color: Colors.black87),
        ),
      );
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final hasContent = phrase.isNotEmpty || hashtags.isNotEmpty;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Results'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Results Section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasContent) ...[
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.format_quote,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Phrase:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              phrase.isEmpty
                                  ? const Text(
                                'No phrase entered',
                                style: TextStyle(color: Colors.grey),
                              )
                                  : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8),
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 16),
                                    children: highlightHashtags(phrase),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.tag,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Hashtags:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              hashtags.isEmpty
                                  ? const Text(
                                'No hashtags found',
                                style: TextStyle(color: Colors.grey),
                              )
                                  : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8),
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 16),
                                    children:
                                    highlightHashtags(hashtags),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 80),
                      Icon(
                        Icons.notes,
                        size: 80,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'No content yet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Go to Screen C to create your first phrase',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ]
                  ],
                ),
              ),
            ),

            // Buttons Section
            const SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.pushNamed(
                      'screenC',
                      extra: {
                        'phrase': phrase,
                        'hashtags': hashtags,
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit / Create New'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Show Done button only if there is content
                if (hasContent)
                  OutlinedButton.icon(
                    onPressed: () {
                      context.go('/');
                      Future.delayed(const Duration(milliseconds: 300), () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Row(
                              children: [
                                Icon(Icons.celebration, color: Colors.amber),
                                SizedBox(width: 12),
                                Text('Congratulations 🎉'),
                              ],
                            ),
                            content: const Text(
                              'You have successfully completed the challenge!',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('OK'),
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        );
                      });
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Done'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}