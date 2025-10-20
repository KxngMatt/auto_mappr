import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'default_field.auto_mappr.dart';

@AutoMappr([
  MapType<NestedDto, Nested>(),
  // value
  MapType<ComplexPositionalValueDto, ComplexPositionalValue>(
    fields: [Field('name', whenNull: Nested(id: 963, name: 'tag test'))],
  ),
  MapType<ComplexNamedValueDto, ComplexNamedValue>(
    fields: [Field('name', whenNull: Nested(id: 492, name: 'tag test 2'))],
  ),
  MapType<PrimitivePositionalValueDto, PrimitivePositionalValue>(
    fields: [Field('name', whenNull: 'test abc')],
  ),
  MapType<PrimitiveNamedValueDto, PrimitiveNamedValue>(
    fields: [Field('name', whenNull: 'test def')],
  ),
  // function
  MapType<ComplexPositionalFunctionDto, ComplexPositionalFunction>(
    fields: [Field('name', whenNull: Mappr.defaultNested)],
  ),
  MapType<ComplexNamedFunctionDto, ComplexNamedFunction>(
    fields: [Field('name', whenNull: Mappr.defaultNested)],
  ),
  MapType<PrimitivePositionalFunctionDto, PrimitivePositionalFunction>(
    fields: [Field('name', whenNull: Mappr.defaultString)],
  ),
  MapType<PrimitiveNamedFunctionDto, PrimitiveNamedFunction>(
    fields: [Field('name', whenNull: Mappr.defaultString)],
  ),
])
class Mappr extends $Mappr {
  static Nested defaultNested() => const Nested(id: 1, name: 'default_TAG');

  static String defaultString() => 'Test123';
}

// Nested object

class Nested extends Equatable {
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  const Nested({required this.id, required this.name});
}

class NestedDto {
  final int id;
  final String name;

  const NestedDto(this.id, {required this.name});
}

// --- Value

// Complex

class ComplexPositionalValue extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  const ComplexPositionalValue(this.age, this.name);
}

class ComplexPositionalValueDto {
  final int age;
  final NestedDto? name;

  const ComplexPositionalValueDto(this.age, this.name);
}

class ComplexNamedValue extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  const ComplexNamedValue({required this.age, required this.name});
}

class ComplexNamedValueDto {
  final int age;
  final NestedDto? name;

  const ComplexNamedValueDto({required this.age, required this.name});
}

// Primitive

class PrimitivePositionalValue extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  const PrimitivePositionalValue(this.age, this.name);
}

class PrimitivePositionalValueDto {
  final int age;
  final String? name;

  const PrimitivePositionalValueDto(this.age, this.name);
}

class PrimitiveNamedValue extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  const PrimitiveNamedValue({required this.age, required this.name});
}

class PrimitiveNamedValueDto {
  final int age;
  final String? name;

  const PrimitiveNamedValueDto({required this.age, required this.name});
}

// --- Function

// Complex

class ComplexPositionalFunction extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  const ComplexPositionalFunction(this.age, this.name);
}

class ComplexPositionalFunctionDto {
  final int age;
  final NestedDto? name;

  const ComplexPositionalFunctionDto(this.age, this.name);
}

class ComplexNamedFunction extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  const ComplexNamedFunction({required this.age, required this.name});
}

class ComplexNamedFunctionDto {
  final int age;
  final NestedDto? name;

  const ComplexNamedFunctionDto({required this.age, required this.name});
}

// Primitive

class PrimitivePositionalFunction extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  const PrimitivePositionalFunction(this.age, this.name);
}

class PrimitivePositionalFunctionDto {
  final int age;
  final String? name;

  const PrimitivePositionalFunctionDto(this.age, this.name);
}

class PrimitiveNamedFunction extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  const PrimitiveNamedFunction({required this.age, required this.name});
}

class PrimitiveNamedFunctionDto {
  final int age;
  final String? name;

  const PrimitiveNamedFunctionDto({required this.age, required this.name});
}
