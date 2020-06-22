import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirquit/src/navigator/navigator.dart';
import 'package:sirquit/src/sections/calculator/bloc/lp_calculator_events.dart';
import 'package:sirquit/src/sections/calculator/bloc/lpcalulator_bloc_bloc.dart';
import 'package:sirquit/src/ui/components/drawerMenu.dart';
import 'package:sirquit/src/ui/components/dynamicDropdownButton.dart';
import 'package:sirquit/src/ui/components/persistentAppBar.dart';

class Calculators extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalculatorsState();
}

// State class
class _CalculatorsState extends State<Calculators> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersistentAppBar("Calculators").build(context),
      drawer: DrawerMenu(),
      drawerEdgeDragWidth: 60,
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("Low Pass filter"),
            onTap: () {
              navigateInternal(kLowPass, context);
            },
          ),
        ],
      ),
    );
  }
}

//
// Sections
//

class LPFilterCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LPFilterCalculatorState();
}

class _LPFilterCalculatorState extends State<LPFilterCalculator> {
  LPCalulatorBloc _lpCalulatorBloc;
  static const radiansPerSec = 0.159154;
  final resistanceTextController = TextEditingController();
  final capacitorTextController = TextEditingController();
  final frequencyTextController = TextEditingController();

  bool resistanceEnabled = true;
  bool capacitorEnabled = true;
  bool frequencyEnabled = true;

  ValueNotifier<bool> resistanceShown = ValueNotifier<bool>(true);
  ValueNotifier<bool> capacitorShown = ValueNotifier<bool>(true);
  ValueNotifier<bool> frequencyShown = ValueNotifier<bool>(true);
  ValueNotifier<double> filterResult = ValueNotifier<double>(null);

  bool checkResistanceController() {
    resistanceShown.value = frequencyTextController.text.isEmpty ||
        capacitorTextController.text.isEmpty;
    return resistanceShown.value;
  }

  bool checkCapacitorController() {
    capacitorShown.value = frequencyTextController.text.isEmpty ||
        resistanceTextController.text.isEmpty;
    return capacitorShown.value;
  }

  bool checkFrequencyController() {
    frequencyShown.value = resistanceTextController.text.isEmpty ||
        capacitorTextController.text.isEmpty;
    return frequencyShown.value;
  }

  bool enableButton() =>
      !checkFrequencyController() ||
      !checkCapacitorController() ||
      !checkResistanceController();

  @override
  void initState() {
    super.initState();
    _lpCalulatorBloc = LPCalulatorBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersistentAppBar("Low Pass Filter").build(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(fit: FlexFit.loose, child: createCalculator()),
          ],
        ),
      ),
    );
  }

  Widget createCalculator() {
    return BlocProvider(
      create: (BuildContext context) => _lpCalulatorBloc,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Form(
                  onChanged: () => setState(() {}),
                  child: Column(children: <Widget>[
                    /// Resistance
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        enabled: checkResistanceController(),
                        controller: resistanceTextController,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter resistance value',
                        ),
                      ),
                    ),

                    /// Capacitor
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        enabled: checkCapacitorController(),
                        controller: capacitorTextController,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Enter capacitor value'),
                      ),
                    ),

                    /// Frequency
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        enabled: checkFrequencyController(),
                        controller: frequencyTextController,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Enter desired cutoff frequency'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),

              /// DropDownButtonMenu
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    dynamicDropdownButton(
                        resistanceShown,
                        resMeasures,
                        (value) =>
                            _lpCalulatorBloc.add(ResistanceUnitChanged(value))),
                    dynamicDropdownButton(
                        capacitorShown,
                        capMeasures,
                        (value) =>
                            _lpCalulatorBloc.add(CapacitorUnitChanged(value))),
                    dynamicDropdownButton(
                        frequencyShown,
                        freqMeasures,
                        (value) =>
                            _lpCalulatorBloc.add(FrequencyUnitChanged(value))),
                  ],
                ),
              ),
            ],
          ),

          /// Button and result
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /// Button
              RaisedButton(
                elevation: 5.0,
                color: Colors.orangeAccent,
                child: Text('Calculate'),
                onPressed: enableButton()
                    ? () {
                        calculateLowPass();
                      }
                    : null,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: ValueListenableBuilder(
                  valueListenable: filterResult,
                  builder: (BuildContext context, value, Widget child) {
                    return Visibility(
                      visible: value != null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              filterResult.value.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool calculateLowPass() {
    var resistance = resistanceTextController.text.trim();
    var capacitor = capacitorTextController.text.trim();
    var frequency = frequencyTextController.text.trim();

    var resInt;
    var capInt;
    var freqInt;

    if (resistance.isNotEmpty) {
      resInt = int.parse(resistance);
    }
    if (capacitor.isNotEmpty) {
      capInt = int.parse(capacitor);
    }
    if (frequency.isNotEmpty) {
      freqInt = int.parse(frequency);
    }
    /*

      Capacitance = ( 1/2pi) / (FR) Farad
      Frequency = ( 1/ 2pi) / C / R Hz Ohm base 200
      Resistance = ( 1/2pi) / (C/F) Farad

     */

    if (resInt != null) {
      if (capInt != null) {
        //Calculate Frequency
        print('Calculating F');
        filterResult.value = (radiansPerSec / resInt / capInt);
      } else {
        // Calculate Capacitance
        print('Calculating C');
        filterResult.value = (radiansPerSec / freqInt / resInt);
      }
    } else if (capInt != null) {
      if (freqInt != null) {
        //Calculate Resistance
        print('Calculating R');
        filterResult.value = (radiansPerSec / capInt / freqInt);
      }
    }
    return true;
  }

  @override
  void dispose() {
    frequencyTextController.dispose();
    super.dispose();
  }

  final resMeasures = ['Ω', 'kΩ', 'MΩ'];
  final capMeasures = ['F', '	mF', 'μF', 'nF', 'pF'];
  final freqMeasures = ['Hz', 'KHz', 'MHz'];
}

enum ReistanceUnits { OHM, KOHM, MOH }

enum CapacitorUnits { FARAD, MILLIF, MICROF, NANOF, PICOF }

enum FrequencyUnits { HERTZ, KHERTZ, MHERTZ }
