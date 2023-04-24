import 'package:flutter_string_to_rich_text/flutter_string_to_rich_text.dart';
import 'package:flutter_test/flutter_test.dart';

void expectListEqual(List<Element> actual, List expected) {
  expect(actual.length, expected.length);
  var index = 0;
  for (var item in actual) {
    var testItem = expected[index];
    var type = testItem[0] as Type;
    var text = testItem[1] as String;
    expect(item.runtimeType, type);
    expect(item.text, text);

    // next
    index = index + 1;
  }
}

void main() {
  test('string to List', () {
    expectListEqual(stringToRichText("你好"), [
      [TextElement, "你好"],
    ]);
  });

  test('string with url to List', () {
    expectListEqual(
      stringToRichText("你好 https://www.baidu.com"),
      [
        [TextElement, "你好 "],
        [UrlElement, "https://www.baidu.com"],
      ],
    );
  });

  test('string with multiple urls to List', () {
    expectListEqual(
      stringToRichText("你好 https://www.baidu.com 世界 https://www.google.com"),
      [
        [TextElement, "你好 "],
        [UrlElement, "https://www.baidu.com"],
        [TextElement, " 世界 "],
        [UrlElement, "https://www.google.com"],
      ],
    );
  });

  test('string with multiple line urls to List', () {
    expectListEqual(
      stringToRichText("""你好 https://www.baidu.com 
世界 https://www.google.com """),
      [
        [TextElement, "你好 "],
        [UrlElement, "https://www.baidu.com"],
        [TextElement, " \n世界 "],
        [UrlElement, "https://www.google.com"],
        [TextElement, " "],
      ],
    );
  });

  test('string with sticker to List', () {
    expectListEqual(
      stringToRichText("""你好[握手]"""),
      [
        [TextElement, "你好"],
        [StickerElement, "[握手]"],
      ],
    );
  });

  test('custom sticker onMatch', () {
    final parsers = <Parser>[
      UrlElement.parser(),
      StickerElement.parser(
        onMatch: (match) {
          return match[1] == "哈哈";
        },
      )
    ];
    expectListEqual(
      stringToRichText(
        """你好[握手][[哈哈]]""",
      ),
      [
        [TextElement, "你好"],
        [StickerElement, "[握手]"],
        [TextElement, "["],
        [StickerElement, "[哈哈]"],
        [TextElement, "]"],
      ],
    );
    expectListEqual(
      stringToRichText(
        """你好[握手][[哈哈]]""",
        parsers: parsers,
      ),
      [
        [TextElement, "你好"],
        [TextElement, "[握手]"],
        [TextElement, "["],
        [StickerElement, "[哈哈]"],
        [TextElement, "]"],
      ],
    );
  });

  test('custom sticker regex', () {
    final parsers = <Parser>[
      UrlElement.parser(),
      StickerElement.parser(
        regex: RegExp(r'\[(哈哈|haha)\]|\[(亲亲|kiss)\]'),
      )
    ];
    expectListEqual(
      stringToRichText(
        """你好[握手][哈哈][kiss]""",
        parsers: parsers,
      ),
      [
        [TextElement, "你好[握手]"],
        [StickerElement, "[哈哈]"],
        [StickerElement, "[kiss]"],
      ],
    );
  });
}
