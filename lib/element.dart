export "./elements/newline.dart";
export "./elements/sticker.dart";
export "./elements/text.dart";
export "./elements/url.dart";

typedef Parser = List<Element> Function(List<Element> elements);

mixin ElementMatch {
  late final Match match;
}

abstract class Element {
  final String text;

  Element(this.text);
}
