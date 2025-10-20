import 'package:test/test.dart';

import 'fixture/generics.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('simple', () {
    test('With<num, num> -> With<num, num>', () {
      const dto = fixture.With<num, num>(first: 18, second: 789);
      final converted = mappr.convert<fixture.With<num, num>, fixture.With<num, num>>(dto);

      expect(
        converted,
        equals(const fixture.With<num, num>(first: 18, second: 789)),
      );
    });
    test('With<Object, Object> -> With<Object, Object>', () {
      const dto = fixture.With<Object, Object>(first: 'Some string', second: 123123);
      final converted = mappr.convert<fixture.With<Object, Object>, fixture.With<Object, Object>>(dto);

      expect(
        converted,
        equals(const fixture.With<Object, Object>(first: 'Some string', second: 123123)),
      );
    });
    test('With<int, AlphaDto<num>> -> With<int, Alpha<num>>', () {
      const dto = fixture.With<int, fixture.AlphaDto<num>>(
        first: 69,
        second: fixture.AlphaDto(
          fixture.With<num, num>(first: 741, second: 852.666),
          123,
        ),
      );
      final converted =
          mappr.convert<fixture.With<int, fixture.AlphaDto<num>>, fixture.With<int, fixture.Alpha<num>>>(dto);

      expect(
        converted,
        equals(
          const fixture.With<int, fixture.Alpha<num>>(
            first: 69,
            second: fixture.Alpha(
              fixture.With<num, num>(first: 741, second: 852.666),
              123,
            ),
          ),
        ),
      );
    });
    test('With<String, int> -> Without', () {
      const dto = fixture.With<String, int>(first: 'test abc', second: 111222333);
      final converted = mappr.convert<fixture.With<String, int>, fixture.Without>(dto);

      expect(
        converted,
        equals(const fixture.Without(first: 'test abc', second: 111222333)),
      );
    });
    test('With<String, int> -> With<String, int>', () {
      const dto = fixture.With<String, int>(first: 'test abc 2', second: 741852963);
      final converted = mappr.convert<fixture.With<String, int>, fixture.With<String, int>>(dto);

      expect(
        converted,
        equals(const fixture.With<String, int>(first: 'test abc 2', second: 741852963)),
      );
    });
    test('Without -> With<String, int>', () {
      const dto = fixture.Without(first: 'alpha test', second: 111000);
      final converted = mappr.convert<fixture.Without, fixture.With<String, int>>(dto);

      expect(
        converted,
        equals(const fixture.With<String, int>(first: 'alpha test', second: 111000)),
      );
    });
  });

  group('nested', () {
    test('AlphaDto<num> -> Alpha<num>', () {
      const dto = fixture.AlphaDto<num>(fixture.With<num, num>(first: 1, second: 2), 420);
      final converted = mappr.convert<fixture.AlphaDto<num>, fixture.Alpha<num>>(dto);

      expect(
        converted,
        equals(const fixture.Alpha<num>(fixture.With<num, num>(first: 1, second: 2), 420)),
      );
    });

    test('AlphaDto<int> -> Alpha<int>', () {
      const dto = fixture.AlphaDto<int>(fixture.With(first: 7771, second: 1472), 42);
      final converted = mappr.convert<fixture.AlphaDto<int>, fixture.Alpha<int>>(dto);

      expect(
        converted,
        equals(const fixture.Alpha<int>(fixture.With(first: 7771, second: 1472), 42)),
      );
    });

    test('AlphaDto<String> -> Alpha<String>', () {
      const dto = fixture.AlphaDto<String>(fixture.With(first: 'test a', second: 'test b'), 42);
      final converted = mappr.convert<fixture.AlphaDto<String>, fixture.Alpha<String>>(dto);

      expect(
        converted,
        equals(const fixture.Alpha<String>(fixture.With(first: 'test a', second: 'test b'), 42)),
      );
    });
  });

  group('collections', () {
    test(
      'ListHolder<int, AlphaDto<num>> -> ListHolder<int, Alpha<num>>',
      () {
        const dto = fixture.ListHolder<int, fixture.AlphaDto<num>>(
          [
            fixture.With<int, fixture.AlphaDto<num>>(
              first: 13,
              second: fixture.AlphaDto(fixture.With(first: 11.7, second: 12.99), 130),
            ),
            fixture.With<int, fixture.AlphaDto<num>>(
              first: 28,
              second: fixture.AlphaDto(fixture.With(first: 77, second: 99.99), 20),
            ),
          ],
        );
        final converted = mappr
            .convert<fixture.ListHolder<int, fixture.AlphaDto<num>>, fixture.ListHolder<int, fixture.Alpha<num>>>(dto);

        expect(
          converted,
          equals(
            const fixture.ListHolder<int, fixture.Alpha<num>>(
              [
                fixture.With<int, fixture.Alpha<num>>(
                  first: 13,
                  second: fixture.Alpha(fixture.With(first: 11.7, second: 12.99), 130),
                ),
                fixture.With<int, fixture.Alpha<num>>(
                  first: 28,
                  second: fixture.Alpha(fixture.With(first: 77, second: 99.99), 20),
                ),
              ],
            ),
          ),
        );
      },
    );

    test('SetHolder<String> -> SetHolder<String>', () {
      final dto = fixture.SetHolder<String>(
        {
          const fixture.With<String, String>(
            first: 'alpha x1',
            second: 'alpha x2',
          ),
          const fixture.With<String, String>(
            first: 'alpha x3',
            second: 'alpha x4',
          ),
        },
      );
      final converted = mappr.convert<fixture.SetHolder<String>, fixture.SetHolder<String>>(dto);

      expect(
        converted,
        equals(
          fixture.SetHolder<String>(
            {
              const fixture.With<String, String>(
                first: 'alpha x1',
                second: 'alpha x2',
              ),
              const fixture.With<String, String>(
                first: 'alpha x3',
                second: 'alpha x4',
              ),
            },
          ),
        ),
      );
    });

    test('IterableHolder<String, int> -> IterableHolder<String, int>', () {
      final dto = fixture.IterableHolder<String, int>(
        {
          const fixture.With<String, int>(first: 'beta y1', second: 4201),
          const fixture.With<String, int>(first: 'beta y2', second: 4202),
        },
      );
      final converted = mappr.convert<fixture.IterableHolder<String, int>, fixture.IterableHolder<String, int>>(dto);

      expect(
        converted,
        equals(
          fixture.IterableHolder<String, int>(
            {
              const fixture.With<String, int>(first: 'beta y1', second: 4201),
              const fixture.With<String, int>(first: 'beta y2', second: 4202),
            },
          ),
        ),
      );
    });

    test(
      'MapHolder<String, int, bool> -> MapHolder<String, int, bool>',
      () {
        const dto = fixture.MapHolder<String, int, bool>(
          {
            'hello test 1': fixture.With<int, bool>(
              first: 999,
              second: true,
            ),
            'hello test 2': fixture.With<int, bool>(
              first: 888,
              second: true,
            ),
            'hello test 3': fixture.With<int, bool>(
              first: 777,
              second: false,
            ),
          },
        );
        final converted =
            mappr.convert<fixture.MapHolder<String, int, bool>, fixture.MapHolder<String, int, bool>>(dto);

        expect(
          converted,
          equals(
            const fixture.MapHolder<String, int, bool>(
              {
                'hello test 1': fixture.With<int, bool>(
                  first: 999,
                  second: true,
                ),
                'hello test 2': fixture.With<int, bool>(
                  first: 888,
                  second: true,
                ),
                'hello test 3': fixture.With<int, bool>(
                  first: 777,
                  second: false,
                ),
              },
            ),
          ),
        );
      },
    );
  });
}
