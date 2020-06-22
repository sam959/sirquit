import 'package:meta/meta.dart';
import 'package:sirquit/src/blocs/calulator_blocs.dart';

@immutable
abstract class LowPassCalculatorEvent extends CalculatorBlocEvent {
  final List myProps;

  const LowPassCalculatorEvent(this.myProps);

  @override
  List<Object> get props => this.myProps;
}

class ResistanceInserted extends LowPassCalculatorEvent {
  final int value;
  ResistanceInserted(this.value) : super([value]);

  @override
  String toString() => 'ResistanceInserted : $value';
}

class CapacitorInserted extends LowPassCalculatorEvent {
  final int value;

  CapacitorInserted(this.value) : super([value]);
  @override
  String toString() => 'CapacitorInserted : $value';
}

class FrequencyInserted extends LowPassCalculatorEvent {
  final int value;

  FrequencyInserted(this.value) : super([value]);
  @override
  String toString() => 'FrequencyInserted : $value';
}

class ResistanceUnitChanged extends LowPassCalculatorEvent {
  final String unit;
  ResistanceUnitChanged(this.unit) : super([unit]);
  @override
  String toString() => 'ResistanceUnitChanged : $unit';
}

class CapacitorUnitChanged extends LowPassCalculatorEvent {
  final String unit;
  CapacitorUnitChanged(this.unit) : super([unit]);
  @override
  String toString() => 'CapacitorUnitChanged : $unit';
}

class FrequencyUnitChanged extends LowPassCalculatorEvent {
  final String unit;
  FrequencyUnitChanged(this.unit) : super([unit]);
  @override
  String toString() => 'FrequencyUnitChanged : $unit';
}

class CalculatePressed extends LowPassCalculatorEvent {
  final bool pressed;
  CalculatePressed(this.pressed) : super([pressed]);
}
