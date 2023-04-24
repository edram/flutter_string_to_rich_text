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
        [TextElement, " "],
        [NewlineElement, "\n"],
        [TextElement, "世界 "],
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

  test('custom sticker regex and match', () {
    final parsers = <Parser>[
      UrlElement.parser(),
      StickerElement.parser(
        regex: RegExp(r'\[(哈哈|haha|亲亲|kiss)\]'),
      )
    ];
    var result = stringToRichText(
      """你好[握手][哈哈][kiss]""",
      parsers: parsers,
    );
    expectListEqual(
      result,
      [
        [TextElement, "你好[握手]"],
        [StickerElement, "[哈哈]"],
        [StickerElement, "[kiss]"],
      ],
    );

    var stickers = [result[1] as StickerElement, result[2] as StickerElement];

    expect(stickers[0].match[1], "哈哈");
    expect(stickers[1].match[1], "kiss");
  });
}
