import 'package:sirquit/src/blocs/calulator_blocs.dart';

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

class CalculatorResistanceInProgress extends LowPassCalculatorState {
  final String value;
  CalculatorResistanceInProgress(this.value) : super([value]);

  @override
  String toString() => 'CalculatorInitial';
}

class CalculatorCapacitorInProgress extends LowPassCalculatorState {
  final String value;
  CalculatorCapacitorInProgress(this.value) : super([value]);

  @override
  String toString() => 'CalculatorCapacitorInProgress';
}

class CalculatorFrequencyInProgress extends LowPassCalculatorState {
  final String value;
  CalculatorFrequencyInProgress(this.value) : super([value]);

  @override
  String toString() => 'CalculatorFrequencyInProgress';
}

class CalculatorSuccess extends LowPassCalculatorState {
  final String result;

  CalculatorSuccess(this.result) : super([result]);

  @override
  String toString() => 'CalculatorSuccess: $result';
}
