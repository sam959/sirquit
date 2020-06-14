import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: PersistentAppBar("Low Pass Filter").build(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          createCalculator(),
        ],
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
                color: Colors.deepOrange,
                child: Text('Calculate'),
                onPressed: enableButton() ? () => calculateLowPass() : null,
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
              dropdownButton(
                  <String>['Ohms', '2', '3'], (value) => print(value)),
              dropdownButton(
                  <String>['Ohms', '2', '3'], (value) => print(value)),
              dropdownButton(
                  <String>['Ohms', '2', '3'], (value) => print(value)),
            ],
          ),
        ),
      ],
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
