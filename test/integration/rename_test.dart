import 'package:test/test.dart';

import 'fixture/rename.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  group('same', () {
    test(
      'Renamed fields with the same name when using positional parameters',
      () {
        const dto = fixture.SamePositionalDto(123, 'test');
        final converted = mappr.convert<fixture.SamePositionalDto, fixture.SamePositional>(dto);

        expect(converted, equals(const fixture.SamePositional(123, 'test')));
      },
    );

    test(
      'Renamed fields with the same name when using named parameters',
      () {
        const dto = fixture.SameNamedDto(id: 123, name: 'test');
        final converted = mappr.convert<fixture.SameNamedDto, fixture.SameNamed>(dto);

        expect(converted, equals(const fixture.SameNamed(id: 123, name: 'test')));
      },
    );
  });

  group('primitive', () {
    test('Renamed when using positional parameters', () {
      const dto = fixture.PrimitivePositionalDto(456);
      final converted = mappr.convert<fixture.PrimitivePositionalDto, fixture.PrimitivePositional>(dto);

      expect(converted, equals(const fixture.PrimitivePositional(456)));
    });

    test('Renamed when using named parameters', () {
      const dto = fixture.PrimitiveNamedDto(idx: 456);
      final converted = mappr.convert<fixture.PrimitiveNamedDto, fixture.PrimitiveNamed>(dto);

      expect(converted, equals(const fixture.PrimitiveNamed(id: 456)));
    });
  });

  group('primitive reversed', () {
    test('Renamed when using positional parameters', () {
      const dto = fixture.PrimitivePositionalReversedDto('test123', 789);
      final converted = mappr.convert<fixture.PrimitivePositionalReversedDto, fixture.PrimitivePositionalReversed>(dto);

      expect(
        converted,
        equals(const fixture.PrimitivePositionalReversed(789, 'test123')),
      );
    });

    test('Renamed when using named parameters', () {
      const dto = fixture.PrimitiveNamedReversedDto(alpha: 'test741', beta: 258);
      final converted = mappr.convert<fixture.PrimitiveNamedReversedDto, fixture.PrimitiveNamedReversed>(dto);

      expect(
        converted,
        equals(const fixture.PrimitiveNamedReversed(alpha: 258, beta: 'test741')),
      );
    });
  });

  group('complex', () {
    test('Renamed when using positional parameters', () {
      const dto = fixture.ComplexPositionalDto(fixture.NestedDto(13, namex: 'testtest3'));
      final converted = mappr.convert<fixture.ComplexPositionalDto, fixture.ComplexPositional>(dto);

      expect(
        converted,
        equals(const fixture.ComplexPositional(fixture.Nested(id: 13, name: 'testtest3'))),
      );
    });

    test('Renamed when using named parameters', () {
      const dto = fixture.ComplexNamedDto(datax: fixture.NestedDto(789123, namex: 'xyz'));
      final converted = mappr.convert<fixture.ComplexNamedDto, fixture.ComplexNamed>(dto);

      expect(
        converted,
        equals(const fixture.ComplexNamed(data: fixture.Nested(id: 789123, name: 'xyz'))),
      );
    });
  });

  group('complex reversed', () {
    test('Renamed when using positional parameters', () {
      const dto = fixture.ComplexPositionalReversedDto(fixture.NestedReversedDto('testtest3', namex: 13), 951);
      final converted = mappr.convert<fixture.ComplexPositionalReversedDto, fixture.ComplexPositionalReversed>(dto);

      expect(
        converted,
        equals(const fixture.ComplexPositionalReversed(951, fixture.NestedReversed(id: 13, name: 'testtest3'))),
      );
    });

    test('Renamed when using named parameters', () {
      const dto = fixture.ComplexNamedReversedDto(first: fixture.NestedReversedDto('hello', namex: 666), second: 18);
      final converted = mappr.convert<fixture.ComplexNamedReversedDto, fixture.ComplexNamedReversed>(dto);

      expect(
        converted,
        equals(const fixture.ComplexNamedReversed(first: 18, second: fixture.NestedReversed(id: 666, name: 'hello'))),
      );
    });
  });

  group('custom', () {
    test('Renamed when using positional parameters', () {
      const dto = fixture.CustomPositionalDto(1, 'computer');
      final converted = mappr.convert<fixture.CustomPositionalDto, fixture.CustomPositional>(dto);

      expect(converted, equals(const fixture.CustomPositional('computer #1')));
    });

    test('Renamed when using named parameters', () {
      const dto = fixture.CustomNamedDto(id: 11, name: 'monitor');
      final converted = mappr.convert<fixture.CustomNamedDto, fixture.CustomNamed>(dto);

      expect(converted, equals(const fixture.CustomNamed(nameAndId: 'monitor #11')));
    });
  });

  group('with no constructor and with late fields', () {
    test('Renamed when using positional parameters', () {
      const dto = fixture.NoConstructorWithLateDto(value: 42, secondValue: 'colosseum');
      final converted = mappr.convert<fixture.NoConstructorWithLateDto, fixture.NoConstructorWithLate>(dto);

      expect(
        converted,
        equals(
          fixture.NoConstructorWithLate()
            ..alpha = 42
            ..beta = 'colosseum',
        ),
      );
    });
  });
}
