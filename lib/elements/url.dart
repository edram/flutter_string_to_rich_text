import 'package:flutter_string_to_rich_text/element.dart';

final regex = RegExp(
  r'https?:\/\/([A-Z0-9.-]+)(:[0-9]+)?(\/[^?]*)?',
  caseSensitive: false,
);

class UrlElement extends Element {
  UrlElement(super.text);

  static List<Element> parse(List<Element> elements) {
    final list = <Element>[];

    for (var element in elements) {
      if (element is! TextElement) {
        list.add(element);
      }

      element.text.splitMapJoin(
        regex,
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
  }
}
