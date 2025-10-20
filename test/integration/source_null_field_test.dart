import 'package:test/test.dart';

import 'fixture/forced_null_source_field.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('Source with nullable fields are forced to non-null values', () {
    const source = fixture.Source(id: 'a', name: 'name');

    final target = mappr.convert<fixture.Source, fixture.Target>(source);

    expect(target.id, equals('a'));
    expect(target.name, equals('name'));
  });
}
