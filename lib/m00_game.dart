import 'package:flutter/material.dart';

import 'l00_local_back.dart' as l00;   // local_back_00
import 'd00_word_score_s.dart' as d00;


enum CandidateType { none, anyChar, uniqueChar } // SegmentedButton <-> this_enum <-> l00.gameStep.getTop unique_or_not

class TheGame extends ChangeNotifier {

  static const CandidateType  defCndType = CandidateType.uniqueChar;
  static const int            defWordLen = l00.GameStep.defWordLen;
  static const int            defNumOfStep_s = 6;

  final List<l00.GameStep> step_s = [];
  CandidateType candidateType = defCndType;

  ({d00.WordNScore Function(int) func, int limit}) get candidateFuncAndLimit {
    switch(((step_s.isEmpty), candidateType)) {
      case ((true, CandidateType.anyChar)):
        return (func: l00.GameStep.getDefAnyCandidate, limit: l00.GameStep.defAnyLen);
      case ((true, CandidateType.uniqueChar)):
        return (func: l00.GameStep.getDefUniCandidate, limit: l00.GameStep.defUniqueLen);
      case((false, CandidateType.anyChar)):
        return (func: step_s.last.getAnyCandidate, limit: step_s.last.anyLen);
      case((false, CandidateType.uniqueChar)):
        return (func: step_s.last.getUniCandidate, limit: step_s.last.uniqueLen);
      default:
        return (func: l00.GameStep.getDefAnyCandidate, limit: l00.GameStep.defAnyLen);
    }
  }

  void selectCandidateType(Set<CandidateType> input) {
    candidateType = input.first;
    notifyListeners();
  }

  void addStep(List<({String chr, l00.Clr clr})> word) {
    step_s.add(l00.GameStep.next(step_s.isEmpty ? null : step_s.last, word));
    notifyListeners();
  }

  void clear() {
    step_s.clear();
    notifyListeners();
  }

  void back() {
    if (step_s.isEmpty) { return; }
    step_s.removeLast();
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


TheGame notForProd() {
  TheGame rlt = TheGame();
  rlt.addStep([
    (chr: '1', clr: l00.Clr.green,),
    (chr: '2', clr: l00.Clr.yellow,),
    (chr: '3', clr: l00.Clr.grey,),
    (chr: '4', clr: l00.Clr.grey,),
    (chr: '5', clr: l00.Clr.grey,),
  ]);
  rlt.addStep([
    (chr: 'a', clr: l00.Clr.grey,),
    (chr: 'b', clr: l00.Clr.grey,),
    (chr: 'c', clr: l00.Clr.yellow,),
    (chr: 'd', clr: l00.Clr.yellow,),
    (chr: 'e', clr: l00.Clr.green,),
  ]);
  return rlt;
}
