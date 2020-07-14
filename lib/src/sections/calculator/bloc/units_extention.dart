abstract class Units {}


extension UnitConverter on String{

  void  fromStringToUnit(){

  }

}
class ResistanceUnits extends Units {
  static const String OHM = 'Ω';
  static const String KOHM = 'kΩ';
  static const String MOH = 'MΩ';

  static List<String> values() => [OHM, KOHM,MOH];
}

class CapacitorUnits extends Units {
  static const String FARAD = 'F';
  static const String MILLIF = 'mF';
  static const String MICROF = 'μF';
  static const String NANOF = 'nF';
  static const String PICOF = 'pF';
  static List<String> values() => [FARAD, MILLIF,MICROF,NANOF,PICOF];

}

class FrequencyUnits extends Units {
  static const String HERTZ = 'Hz';
  static const String KHERTZ = 'KHz';
  static const String MHERTZ = 'MHz';
  static List<String> values() => [HERTZ, KHERTZ,MHERTZ];

}

final resMeasures = ['Ω', 'kΩ', 'MΩ'];
final capMeasures = ['F', 'mF', 'μF', 'nF', 'pF'];
final freqMeasures = ['Hz', 'KHz', 'MHz'];
