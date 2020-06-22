import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class CalculatorBloc
    extends Bloc<CalculatorBlocEvent, CalculatorBlocState> {}

abstract class CalculatorBlocEvent extends Equatable {
  const CalculatorBlocEvent() : super();
}

abstract class CalculatorBlocState extends Equatable {
  const CalculatorBlocState() : super();
}
