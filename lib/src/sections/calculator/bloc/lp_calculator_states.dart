import 'package:sirquit/src/blocs/calulator_blocs.dart';
import 'package:sirquit/src/sections/calculator/bloc/units_extention.dart';

abstract class LowPassCalculatorState extends CalculatorBlocState {
  final List myProps;

  const LowPassCalculatorState(this.myProps);

  @override
  List<Object> get props => this.myProps;
}

class CalculatorInitial extends LowPassCalculatorState {
  CalculatorInitial() : super([]);

  @override
  String toString() => 'CalculatorInitial';
}

/// Input new value
class InputResistanceInProgress extends LowPassCalculatorState {
  final String value;
  InputResistanceInProgress(this.value) : super([value]);

  @override
  String toString() => 'CalculatorResistanceInProgress';
}

class InputCapacitorInProgress extends LowPassCalculatorState {
  final String value;
  InputCapacitorInProgress(this.value) : super([value]);

  @override
  String toString() => 'CalculatorCapacitorInProgress';
}

class InputFrequencyInProgress extends LowPassCalculatorState {
  final String value;
  InputFrequencyInProgress(this.value) : super([value]);

  @override
  String toString() => 'CalculatorFrequencyInProgress';
}

/// Unity changed
class CalculatorResistanceConvertion extends LowPassCalculatorState {
  final String unit;
  CalculatorResistanceConvertion({this.unit}) : super([unit]);
}

class CalculatorCapacitorConvertion extends LowPassCalculatorState {
  final String unit;
  CalculatorCapacitorConvertion({this.unit}) : super([unit]);
}

class CalculatorFrequencyConvertion extends LowPassCalculatorState {
  final String unit;
  CalculatorFrequencyConvertion({this.unit}) : super([unit]);
}

/// Result
class CalculatorSuccess extends LowPassCalculatorState {
  final String result;

  CalculatorSuccess(this.result) : super([result]);

  @override
  String toString() => 'CalculatorSuccess: $result';
}
