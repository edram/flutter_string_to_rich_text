library flutter_string_to_rich_text;

import 'package:flutter_string_to_rich_text/element.dart';

export './element.dart';

final defaultParsers = <Parser>[
  UrlElement.parser(),
  StickerElement.parser(),
  NewlineElement.parser()
];

List<Element> stringToRichText(
  String? text, {
  List<Parser>? parsers,
}) {
  if (text == null) {
    return [];
  }

  parsers ??= defaultParsers;

  var list = [TextElement(text)];

  // url 解析
  List<Element> parseToElementList(List<Element> list) {
    for (var parser in parsers!) {
      list = parser(list);
    }
    return list;
  }

  return parseToElementList(list);
}
