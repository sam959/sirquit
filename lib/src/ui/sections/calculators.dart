import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sirquit/navigator/navigator.dart';
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

  bool checkResistanceController() {
    resistanceShown.value = frequencyTextController.text.isEmpty ||
        capacitorTextController.text.isEmpty;
    var value = resistanceShown.value;
    print('Setting resistance visibility to: $value');
    return resistanceShown.value;
  }

  bool checkCapacitorController() {
    capacitorShown.value = frequencyTextController.text.isEmpty ||
        resistanceTextController.text.isEmpty;
    var value = capacitorShown.value;
    print('Setting capacitor visibility to: $value');
    return capacitorShown.value;
  }

  bool checkFrequencyController() {
    frequencyShown.value = resistanceTextController.text.isEmpty ||
        capacitorTextController.text.isEmpty;
    var value = frequencyShown.value;
    print('Setting frequency visibility to: $value');
    return frequencyShown.value;
  }

  bool enableButton() =>
      !checkFrequencyController() ||
      !checkCapacitorController() ||
      !checkResistanceController();

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
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Form(
            onChanged: () => setState(() {}),
            child: Column(children: <Widget>[
              /// Resistance
              Visibility(
                visible: checkResistanceController(),
                child: SizedBox(
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
              ),

              /// Capacitor
              Visibility(
                visible: checkCapacitorController(),
                child: SizedBox(
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
              ),

              /// Frequency
              Visibility(
                visible: checkFrequencyController(),
                child: SizedBox(
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
              ),
              SizedBox(
                height: 40,
              ),

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
            ]),
          ),
        ),

        /// DropDownButtonMenu
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              dynamicDropdownButton(
                  resistanceShown, resMeasures, (value) => print(value)),
              dynamicDropdownButton(
                  capacitorShown, capMeasures, (value) => print(value)),
              dynamicDropdownButton(
                  frequencyShown, freqMeasures, (value) => print(value)),
            ],
          ),
        ),
      ],
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

    double result;

    if (resInt != null) {
      if (capInt != null) {
        //Calculate Frequency
        print('Calculating F');
        result = (radiansPerSec / resInt / capInt);
      } else {
        // Calculate Capacitance
        print('Calculating C');
        result = (radiansPerSec / freqInt / resInt);
      }
    } else if (capInt != null) {
      if (freqInt != null) {
        //Calculate Resistance
        print('Calculating R');
        result = (radiansPerSec / capInt / freqInt);
      }
    }
    print('Result is $result');
    return true;
  }

  @override
  void dispose() {
    frequencyTextController.dispose();
    super.dispose();
  }

  final resMeasures = ['Ohms', 'KOhms', 'MOhms'];
  final capMeasures = ['Farads', 'Milli', 'Micro', 'Nano', 'Pico'];
  final freqMeasures = ['Hz', 'Khz', 'Mhz'];
}
