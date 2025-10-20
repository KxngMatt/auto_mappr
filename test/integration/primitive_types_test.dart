import 'package:test/test.dart';

import 'fixture/primitive_types.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('num', () {
    for (final value in <num>[-42.69, -3, 0, 420, 666]) {
      test("value '$value' converts", () {
        final dto = fixture.NumHolderDto(value);
        final converted = mappr.convert<fixture.NumHolderDto, fixture.NumHolder>(dto);

        expect(converted.value, equals(dto.value));
      });
    }
  });

  group('int', () {
    for (final value in <int>[-42, -3, 0, 420, 666]) {
      test("value '$value' converts", () {
        final dto = fixture.IntHolderDto(value);
        final converted = mappr.convert<fixture.IntHolderDto, fixture.IntHolder>(dto);

        expect(converted.value, equals(dto.value));
      });
    }
  });

  group('double', () {
    for (final value in <double>[-42.69, -3.12, 0, 420.78, 666.666]) {
      test("value '$value' converts", () {
        final dto = fixture.DoubleHolderDto(value);
        final converted = mappr.convert<fixture.DoubleHolderDto, fixture.DoubleHolder>(dto);

        expect(converted.value, equals(dto.value));
      });
    }
  });

  group('String', () {
    for (final value in <String>['', ' ', 'a', 'aa bb', 'aa, bb, cc']) {
      test("value '$value' converts", () {
        final dto = fixture.StringHolderDto(value);
        final converted = mappr.convert<fixture.StringHolderDto, fixture.StringHolder>(dto);

        expect(converted.value, equals(dto.value));
      });
    }
  });

  group('bool', () {
    for (final value in <bool>[true, false]) {
      test("value '$value' converts", () {
        final dto = fixture.BoolHolderDto(value);
        final converted = mappr.convert<fixture.BoolHolderDto, fixture.BoolHolder>(dto);

        expect(converted.value, equals(dto.value));
      });
    }
  });

  group('enum', () {
    for (final value in <fixture.Enum>[fixture.Enum.alpha, fixture.Enum.beta, fixture.Enum.gama]) {
      test("value '$value' converts", () {
        final dto = fixture.EnumHolderDto(value);
        final converted = mappr.convert<fixture.EnumHolderDto, fixture.EnumHolder>(dto);

        expect(converted.value, equals(dto.value));
      });
    }
  });
}
