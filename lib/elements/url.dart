import 'package:flutter_string_to_rich_text/element.dart';

final _defaultRegex = RegExp(
  r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&\/\/=]*)',
  caseSensitive: false,
);

class UrlElement extends Element {
  UrlElement(super.text);

  static Parser parser({RegExp? regex}) {
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
            list.add(UrlElement(match[0]!));
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
