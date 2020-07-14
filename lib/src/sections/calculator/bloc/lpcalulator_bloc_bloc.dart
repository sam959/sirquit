import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sirquit/src/blocs/calulator_blocs.dart';
import 'package:sirquit/src/sections/calculator/bloc/lp_calculator_states.dart';

import 'lp_calculator_events.dart';

class LPCalulatorBloc extends CalculatorBloc {
  @override
  LowPassCalculatorState get initialState => CalculatorInitial();

  @override
  void onTransition(
      Transition<CalculatorBlocEvent, CalculatorBlocState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<CalculatorBlocState> mapEventToState(
    CalculatorBlocEvent event,
  ) async* {
    yield* _mapCalculatorEventToState(event);
  }
}

Stream<CalculatorBlocState> _mapCalculatorEventToState(
    CalculatorBlocEvent event) async* {
  switch (event.runtimeType) {
    case ResistanceInserted:
      yield InputResistanceInProgress(event.props.first);
      break;
    case CapacitorInserted:
      yield InputCapacitorInProgress(event.props.first);
      break;
    case FrequencyInserted:
      yield InputFrequencyInProgress(event.props.first);
      break;

    /// Unity changes
    case ResistanceUnitChanged:
      String unit = event.props.first;

      yield CalculatorResistanceConvertion(unit: unit);
      break;
    case CapacitorUnitChanged:
      String unit = event.props.first;

      yield CalculatorCapacitorConvertion(unit: unit);
      break;
    case FrequencyUnitChanged:
      String unit = event.props.first;

      yield CalculatorFrequencyConvertion(unit: unit);
      break;
    case CalculatePressed:
      yield CalculatorSuccess(event.props);
      break;
  }
}
