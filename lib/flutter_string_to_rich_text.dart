library flutter_string_to_rich_text;

import 'package:flutter_string_to_rich_text/element.dart';

export './element.dart';

final defaultParsers = [UrlElement.parse];

List<Element> stringToRichText(
  String? text,
) {
  if (text == null) {
    return [];
  }

  var list = [TextElement(text)];

  // url 解析
  List<Element> parseToElementList(List<Element> list) {
    for (var parser in defaultParsers) {
      list = parser(list);
    }
    return list;
  }

  return parseToElementList(list);
}
