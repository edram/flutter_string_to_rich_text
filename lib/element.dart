export "./elements/text.dart";
export "./elements/url.dart";

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
