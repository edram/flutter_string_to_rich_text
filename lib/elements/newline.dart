import 'package:flutter_string_to_rich_text/element.dart';

final _defaultRegex = RegExp(
  r'\n',
  caseSensitive: false,
);

class NewlineElement extends Element {
  NewlineElement(super.text);

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
            list.add(NewlineElement(match[0]!));
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
