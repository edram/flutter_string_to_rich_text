export "./elements/text.dart";
export "./elements/url.dart";
export "./elements/sticker.dart";

typedef Parser = List<Element> Function(List<Element> elements);

abstract class Element {
  final String text;

  Element(this.text);
}
