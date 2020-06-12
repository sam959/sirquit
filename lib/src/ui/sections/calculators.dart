import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sirquit/navigator/navigator.dart';
import 'package:sirquit/src/ui/components/drawerMenu.dart';
import 'package:sirquit/src/ui/components/dropdownButton.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersistentAppBar("Low Pass Filter").build(context),
      body: Column(
        children: <Widget>[
          LowPassInputForm(),
        ],
      ),
    );
  }
}

/// Inputform class for Calculators
class LowPassInputForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LowPassInputFormState();
}

class _LowPassInputFormState extends State<LowPassInputForm> {
  ValueNotifier<bool> pressed = ValueNotifier(false);

  final resistanceTextController = TextEditingController();
  final capacitorTextController = TextEditingController();
  final frequencyTextController = TextEditingController();

  bool resistanceEnabled = true;
  bool capacitorEnabled = true;
  bool frequencyEnabled = true;

  bool checkResistanceController() =>
      frequencyTextController.text.isEmpty ||
      capacitorTextController.text.isEmpty;

  bool checkCapacitorController() =>
      frequencyTextController.text.isEmpty ||
      resistanceTextController.text.isEmpty;

  bool checkFrequencyController() =>
      resistanceTextController.text.isEmpty ||
      capacitorTextController.text.isEmpty;

  bool enableButton() =>
      !checkFrequencyController() ||
      !checkCapacitorController() ||
      !checkResistanceController();

  @override
  Widget build(BuildContext context) {
    print('state update');
    return Form(
      onChanged: () => setState(() {}),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(children: <Widget>[
                /// Resistance
                Visibility(
                  visible: checkResistanceController(),
                  child: TextFormField(
                    enabled: checkResistanceController(),
                    onEditingComplete: () => print('object'),
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
                Visibility(
                  visible: checkCapacitorController(),
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
                Visibility(
                  visible: checkFrequencyController(),
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
                  height: 40,
                ),
                RaisedButton(
                  elevation: 5.0,
                  color: Colors.deepOrange,
                  child: Text('Calculate'),
                  onPressed: enableButton() ? () => calculateLowPass() : null,
                ),
              ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                dropdownButton(<String>['Ohms', '2', '3']),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void calculateLowPass() {
    var resistance = resistanceTextController.text.trim();
    var capacitor = capacitorTextController.text.trim();
    var frequency = frequencyTextController.text.trim();

    var resInt = 0;
    var capInt = 0;
    var freqInt = 0;

    var empty = "";

    if (resistance.isNotEmpty) {
      resInt = int.parse(resistance);
    }
    if (capacitor.isNotEmpty) {
      capInt = int.parse(capacitor);
    }
    if (frequency.isNotEmpty) {
      freqInt = int.parse(frequency);
    }

    print(
        '$checkResistanceController, $checkCapacitorController, $checkFrequencyController');
  }

  @override
  void dispose() {
    frequencyTextController.dispose();
    super.dispose();
  }
}
