import 'src/navigator/navigator.dart';
import 'src/sirquit.dart';
import 'package:flutter/material.dart';

import 'src/sections/calculator/calculators.dart';
import 'src/sections/converters.dart';
import 'src/sections/tutorials.dart';

void main() => runApp(MaterialApp(
      title: 'Sirquit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber.shade500,
        accentColor: Colors.amber.shade700,
      ),
      initialRoute: kHome,
      routes: {
        kHome: (context) => MyApp(title: 'Sirquit'),
        kCalculators: (context) => Calculators(),
        kTutorials: (context) => Tutorials(),
        kConverters: (context) => Converters(),
        kLowPass: (context) => LPFilterCalculator(),
      },
    ));
