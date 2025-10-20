import 'package:analyzer/dart/element/element2.dart';

extension ExecutableElementExtension on ExecutableElement2 {
  // For top-level functions `isStatic` is true
  // but the enclosing element has no display name.
  // This could result in the expression being `.someFunction()` which is invalid.
  // Therefore, we only add the enclosing element's display name if it is not empty.
  String get referCallString =>
      // ignore: avoid-non-null-assertion, ok here
      isStatic && enclosingElement2?.displayName != '' ? '${enclosingElement2!.displayName}.$displayName' : displayName;
}
