import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class ValueObject<T> extends Equatable {
  const ValueObject();    
}