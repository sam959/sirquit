import 'src/sirquit.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Ribes/Documents/My%20Apps/sirquit/lib/src/ui/sections/converters.dart';
import 'file:///C:/Users/Ribes/Documents/My%20Apps/sirquit/lib/src/ui/sections/tutorials.dart';
import 'file:///C:/Users/Ribes/Documents/My%20Apps/sirquit/lib/src/ui/sections/calculators.dart';
import 'package:sirquit/navigator/navigator.dart';

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
