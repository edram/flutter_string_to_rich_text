export "./elements/text.dart";
export "./elements/url.dart";

typedef Parser = List<Element> Function(List<Element> elements);

abstract class Element {
  final String text;

  Element(this.text);

  @override
  bool operator ==(other) => equals(other);

  bool equals(other) =>
      other is Element &&
      other.runtimeType == runtimeType &&
      other.text == text;

  @override
  int get hashCode => text.hashCode;
}
