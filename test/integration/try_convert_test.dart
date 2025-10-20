import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'fixture/try_convert.dart' as fixture;

class _LogService {
  const _LogService();

  // ignore: no-empty-block, for testing purpose only, avoid-unused-parameters
  void log<T>(Object error, T? source) {}
}

class _MockLogService extends Mock implements _LogService {}

void main() {
  late final fixture.Mappr mappr;
  final logService = _MockLogService();

  setUpAll(() {
    mappr = const fixture.Mappr();
    reset(logService);
  });

  group('convert', () {
    test('Throws when no default is configured', () {
      expect(() => mappr.convert<fixture.NestedDto, fixture.Nested>(null), throwsA(predicate((e) => e is Exception)));
    });

    test('Returns default when configured', () {
      expect(
        mappr.convert<fixture.ComplexValueDto, fixture.ComplexValue>(null),
        equals(const fixture.ComplexValue(99, fixture.Nested(id: 123, name: 'test qwerty'), 'male')),
      );
    });
  });

  group('tryConvert', () {
    test('Return null when no default is configured', () {
      expect(mappr.tryConvert<fixture.NestedDto, fixture.Nested>(null), isNull);
    });

    test('Returns default when configured', () {
      expect(
        mappr.tryConvert<fixture.ComplexValueDto, fixture.ComplexValue>(null),
        equals(const fixture.ComplexValue(99, fixture.Nested(id: 123, name: 'test qwerty'), 'male')),
      );
    });

    test('Source gender is null with safe mapping', () {
      const dto = fixture.ComplexValueDto(99, fixture.NestedDto(1, name: 'Joe'), null);

      expect(
        mappr.tryConvert<fixture.ComplexValueDto, fixture.ComplexValue>(
          dto,
          onMappingError: (error, stacktrace, source) => logService.log<fixture.ComplexValueDto>(error, source),
        ),
        isNull,
      );

      final captured = verify(() => logService.log<fixture.ComplexValueDto>(any(), captureAny()))..called(1);
      expect(captured.captured.firstOrNull, equals(dto));
    });

    test('Source gender is null', () {
      expect(
        () => mappr.tryConvert<fixture.ExampleDto, fixture.Example>(const fixture.ExampleDto()),
        throwsA(predicate((e) => e is TypeError)),
      );
    });
  });
}
