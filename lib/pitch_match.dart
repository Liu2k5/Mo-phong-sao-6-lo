class PitchMatch {
  static const _fluteState = [
    [1, [true, true, true, true, true, true]], // do1
    [1, [true, true, true, true, true, false]], // re1
    [1, [true, true, true, true, false, false]], // mi1
    [1, [true, true, true, false, false, false]], // fa1
    [1, [true, true, false, false, false, false]], // sol1
    [1, [true, false, false, false, false, false]], // la1
    [1, [false, false, false, false, false, false]], // si1
    [1, [false, true, true, true, true, true]], // do2
    [2, [true, true, true, true, true, true]], // do2
    [2, [true, true, true, true, true, false]], // re2
    [2, [true, true, true, false, false, false]], // mi2
    [2, [true, true, false, false, false, true]], // fa2
    [2, [true, false, false, false, false, true]], // sol2
    [2, [false, false, false, false, false, true]], // la2
    [2, [false, false, false, false, false, false]], // si2

  ];
  static const _pitchName = ['do1', 're1', 'mi1', 'fa1', 'sol1', 'la1', 'si1', 'do2', 'do2', 're2', 'mi2', 'fa2', 'sol2', 'la2', 'si2'];
  static const _pitchFrequency = <String, double>{
    'do1' : 261.63,
    're1' : 293.66,
    'mi1' : 329.63,
    'fa1' : 349.23,
    'sol1' : 392.00,
    'la1' : 440.00,
    'si1' : 493.88,
    'do2' : 523.25,
    're2' : 587.33,
    'mi2' : 659.25,
    'fa2' : 698.46,
    'sol2' : 783.99,
    'la2' : 880.00,
    'si2' : 987.77
  };


  static String getPitchName(int strength, List<bool> holes) {
    for (int i = 0; i < _fluteState.length; i++) {
      if (_fluteState[i].toString() == [strength, holes].toString()) {
        return _pitchName[i];
      }
    }
    return 'Unknown';
  }

  static double getPitchFrequency(int strength, List<bool> holes) {
    for (int i = 0; i < _fluteState.length; i++) {
      if (_fluteState[i].toString() == [strength, holes].toString()) {
        return _pitchFrequency[_pitchName[i]] ?? 0.0;
      }
    }
    return 0.0;
  }
}