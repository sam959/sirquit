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
    switch (event.runtimeType) {
      case ResistanceInserted:
        break;
      case CapacitorInserted:
        break;
      case FrequencyInserted:
        break;

      /// Unity changes
      case ResistanceUnitChanged:
        yield CalculatorResistanceInProgress(event.props.first);
        break;
      case CapacitorUnitChanged:
        yield CalculatorCapacitorInProgress(event.props.first);
        break;
      case FrequencyUnitChanged:
        yield CalculatorFrequencyInProgress(event.props.first);
        break;
      case CalculatePressed:
        break;
    }
  }
}
