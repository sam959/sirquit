import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const kHome = '/';
const kCalculators = '/calculators';
const kTutorials = '/tutorials';
const kConverters = '/converters';
const kLowPass = '/lowpass';

void openDrawerSection(String route, BuildContext context) {
  print('Opening drawer section $route');
  Navigator.of(context).popUntil(ModalRoute.withName(kHome));
  Navigator.of(context).pushNamed(route);
}

void navigateInternal(String route, BuildContext context) {
  print('Navigating internally to $route...');
  Navigator.of(context).pushNamed(route);
}

void navigateTo(String route, BuildContext context, {Object args}) {
  print('Navigating to $route...');
  Navigator.of(context).pushReplacementNamed(route);
}
