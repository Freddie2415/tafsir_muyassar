import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tafsiri_muyassar/generated/locale_keys.g.dart';

class SearchItemResult extends StatelessWidget {
  final String title;
  final String content;
  final String query;
  final VoidCallback? onSurahTap;
  final VoidCallback? onJuzTap;

  const SearchItemResult({
    super.key,
    required this.title,
    required this.content,
    required this.query,
    required this.onSurahTap,
    required this.onJuzTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: highlightOccurrences(
                query: query,
                source: content,
              ),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10),
          if (onJuzTap != null || onSurahTap != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (onSurahTap != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, elevation: 0.0),
                    onPressed: onSurahTap,
                    child: Text(LocaleKeys.openSurah.tr()),
                  ),
                const SizedBox(width: 20),
                if (onJuzTap != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      elevation: 0.0,
                    ),
                    onPressed: onJuzTap,
                    child: Text(LocaleKeys.openJuz.tr()),
                  ),
              ],
            ),
          const Divider(),
        ],
      ),
    );
  }

  List<TextSpan> highlightOccurrences({
    required String source,
    required String query,
  }) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }

    Iterable matches = query.toLowerCase().allMatches(source.toLowerCase());
    int lastMatchEnd = 0;

    final beforeList =
        source.substring(0, matches.first.start).split(" ").reversed.toList();

    final sourceBefore = beforeList
        .sublist(0, beforeList.length > 8 ? 8 : beforeList.length)
        .reversed
        .join(" ");

    final found = source.substring(matches.first.start, matches.first.end);

    final afterList =
        source.substring(matches.first.end, source.length).split(" ").toList();

    final sourceAfter = afterList
        .sublist(0, afterList.length > 8 ? 8 : afterList.length)
        .join(" ");

    source = sourceBefore + found + sourceAfter;
    matches = query.toLowerCase().allMatches(source.toLowerCase());
    print(source);

    final List<TextSpan> children = [];

    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(
          TextSpan(
            text: source.substring(lastMatchEnd, match.start),
          ),
        );
      }

      children.add(
        TextSpan(
          text: source.substring(match.start, match.end),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      );

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(
          TextSpan(
            text: source.substring(match.end, source.length),
          ),
        );
      }

      lastMatchEnd = match.end;
    }

    return children;
  }
}
