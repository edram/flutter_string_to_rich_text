import 'package:flutter_string_to_rich_text/element.dart';

final _defaultRegex = RegExp(
  r'\[([^\n\[\]]+)\]',
  caseSensitive: false,
);

class StickerElement extends Element with ElementMatch {
  StickerElement(super.text, {required Match match}) {
    this.match = match;
  }

  static Parser parser({
    RegExp? regex,
    bool Function(Match)? onMatch,
  }) {
    regex ??= _defaultRegex;

    Parser parse;

    parse = (List<Element> elements) {
      final list = <Element>[];

      for (var element in elements) {
        if (element is! TextElement) {
          list.add(element);
          continue;
        }

        element.text.splitMapJoin(
          regex!,
          onMatch: (match) {
            var shouldMatch = onMatch?.call(match) ?? true;

            if (shouldMatch) {
              list.add(StickerElement(match[0]!, match: match));
            } else {
              list.add(TextElement(match[0]!));
            }
            return "";
          },
          onNonMatch: (p0) {
            if (p0.isNotEmpty) {
              list.add(TextElement(p0));
            }
            return "";
          },
        );
      }

      return list;
    };

    return parse;
  }
}
