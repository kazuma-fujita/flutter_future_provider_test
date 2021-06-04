import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';

@freezed
abstract class Entity with _$Entity {
  const factory Entity({
    required int id,
    required String title,
  }) = _Entity;
}
