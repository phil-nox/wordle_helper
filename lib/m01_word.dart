import 'package:flutter/material.dart';

import 'l00_local_back.dart' as l00;                       // local_back_00


class TheWord extends ChangeNotifier {
  static const String   defNtVlChr = '-';                 // define not_valid_char
  
  final charNClr_s = List<({String chr, l00.Clr clr})>.filled(l00.GameStep.defWordLen, (chr: defNtVlChr, clr: l00.Clr.grey));
  int   curIdxInWd = 0;

  bool get theWordisNotValid {
    return charNClr_s.any((el) => el.chr == defNtVlChr);
  }

  static final Map<l00.Clr, l00.Clr> colorToggling = {
    l00.Clr.none: l00.Clr.grey,
    l00.Clr.grey: l00.Clr.yellow,
    l00.Clr.yellow: l00.Clr.green,
    l00.Clr.green: l00.Clr.grey,
  };

  void toggleColor(int idx) {
    charNClr_s[idx] = (chr: charNClr_s[idx].chr, clr: colorToggling[charNClr_s[idx].clr]!);
    notifyListeners();
  }

  void setTheWord(String word) {
    for (int idx = 0; idx < l00.GameStep.defWordLen; ++idx) {
      charNClr_s[idx] = (chr: idx < word.length ? word[idx] : defNtVlChr, clr: l00.Clr.grey);
    }
    curIdxInWd = 0;
    notifyListeners();
  }

  void setDefault() {
    charNClr_s.fillRange(0, charNClr_s.length, (chr: defNtVlChr, clr: l00.Clr.grey));
    curIdxInWd = 0;
    notifyListeners();
  }

  void alphabetInput(String char) {
    charNClr_s[curIdxInWd] = (chr: char, clr: l00.Clr.grey);
    curIdxInWd = curIdxInWd < l00.GameStep.defWordLen - 1 ? curIdxInWd + 1 : 0;
    notifyListeners();
  }
}

//  _____         _   _                ___     ____                 _             _             
// |_   _|__  ___| |_(_)_ __   __ _   ( _ )   |  _ \  _____   _____| | ___  _ __ (_)_ __   __ _ 
//   | |/ _ \/ __| __| | '_ \ / _` |  / _ \/\ | | | |/ _ \ \ / / _ \ |/ _ \| '_ \| | '_ \ / _` |
//   | |  __/\__ \ |_| | | | | (_| | | (_>  < | |_| |  __/\ V /  __/ | (_) | |_) | | | | | (_| |
//   |_|\___||___/\__|_|_| |_|\__, |  \___/\/ |____/ \___| \_/ \___|_|\___/| .__/|_|_| |_|\__, |
//                            |___/                                        |_|            |___/ 
//
//  Not production code


TheWord notForProd() {
  TheWord rlt = TheWord();
  return rlt;
}