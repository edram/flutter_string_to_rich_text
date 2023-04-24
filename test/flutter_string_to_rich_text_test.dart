import 'package:collection/collection.dart';
import 'package:flutter_string_to_rich_text/flutter_string_to_rich_text.dart';
import 'package:flutter_test/flutter_test.dart';

final listEqual = const ListEquality().equals;

void expectListEqual(List actual, List expected) {
  expect(
    listEqual(
      actual,
      expected,
    ),
    true,
    reason: "Expected $actual to be $expected",
  );
}

void main() {
  test('string to List', () {
    expectListEqual(
      stringToRichText("你好"),
      [
        TextElement("你好"),
      ],
    );
  });

  test('string with url to List', () {
    expectListEqual(
      stringToRichText("你好 https://www.baidu.com"),
      [
        TextElement("你好 "),
        UrlElement("https://www.baidu.com"),
      ],
    );
  });

  test('string with multiple urls to List', () {
    expectListEqual(
      stringToRichText("你好 https://www.baidu.com 世界 https://www.google.com"),
      [
        TextElement("你好 "),
        UrlElement("https://www.baidu.com"),
        TextElement(" 世界 "),
        UrlElement("https://www.google.com"),
      ],
    );
  });

  test('string with multiple line urls to List', () {
    expectListEqual(
      stringToRichText("""你好 https://www.baidu.com 
世界 https://www.google.com """),
      [
        TextElement("你好 "),
        UrlElement("https://www.baidu.com"),
        TextElement(" \n世界 "),
        UrlElement("https://www.google.com"),
        TextElement(" "),
      ],
    );
  });
}
