
import 'd00_word_score_s.dart' as d00; // data_00

enum Clr { none, grey, yellow, green }

class GameStep {
  static const int defWordLen = 5;
  static const List<d00.WordNScore> scoreWord_s = d00.scoreWord_s;
  static final List<int> defAny = List.generate(d00.scoreWord_s.length, (idx) => idx, growable: false);
  static final List<int> defUnique = d00.unique;
  static final int defAnyLen = d00.scoreWord_s.length;
  static final int defUniqueLen = d00.unique.length;

  late List<int>                                        any;
  late List<int>                                        unique;
  late List<({String chr, Clr clr})>                    word;

  GameStep.next(GameStep? prevStep, word) {
    if (word.length != defWordLen) {
      throw 'GameStep($word) has bad length. ${word.length} != $defWordLen';
    }
    
    this.word = List.of(word);                              // copy
    any = [];
    unique = [];

    Set<String> targetWordHas = {};
    Set<String> targetWordNotHave = {};

    for (({String chr, Clr clr}) elem in word) {
      switch (elem.clr) {
        case Clr.yellow:
          targetWordHas.add(elem.chr);
          targetWordNotHave.remove(elem.chr);  // case 'e' at pos 1 has Clr.yellow & 'e' at pos 4 has Clr.grey
        case Clr.green:
          targetWordNotHave.remove(elem.chr);
        default:
          targetWordNotHave.add(elem.chr);
      }
    }

    Iterator<int> uniqueFiveItr = prevStep != null ? prevStep.unique.iterator : defUnique.iterator;
    int? curUniFive = uniqueFiveItr.moveNext() ? uniqueFiveItr.current : null;

    for (int idx in prevStep != null ? prevStep.any : defAny) {

      bool uniqueLogic = curUniFive != null ? idx == curUniFive : false;
      if (uniqueLogic) {
        curUniFive = uniqueFiveItr.moveNext() ? uniqueFiveItr.current : null;
      }
      String wordToCheck = scoreWord_s[idx].word;
      Set<String> checkSet = Set.from(wordToCheck.split(''));

      if (targetWordHas.difference(checkSet).isNotEmpty) {
        continue;
      }

      if (targetWordNotHave.intersection(checkSet).isNotEmpty) {
        continue;
      }

      bool skip = false;
      for (int cdx = 0; cdx < word.length; ++cdx) {   // cdx - char_index 
        ({String chr, Clr color,}) cur = (chr: word[cdx].chr, color: word[cdx].clr);        
        
        if (cur.color == Clr.green && cur.chr != wordToCheck[cdx]) {
          skip = true;
          break;
        }

        if (cur.color == Clr.yellow && cur.chr == wordToCheck[cdx]) {
          skip = true;
          break;
        }
      }
      if (skip) {
        continue;
      }

      any.add(idx);
      if (uniqueLogic) {
        unique.add(idx);
      }
    }
  }

  int get anyLen => any.length;
  int get uniqueLen => unique.length;

  d00.WordNScore getAnyCandidate(int n) {
    if (n < 0 || n >= any.length) {
      throw 'RangeError: use "anyLen" property';
    }
    return scoreWord_s[any[n]];
  }

  d00.WordNScore getUniCandidate(int n) {
    if (n < 0 || n >= unique.length) {
      throw 'RangeError: use "uniqueFive" property';
    }
    return scoreWord_s[unique[n]];
  }

  static d00.WordNScore getDefAnyCandidate(int n) {
    if (n < 0 || n >= defAnyLen) {
      throw 'RangeError: use "defAnyLen" property';
    }
    return scoreWord_s[defAny[n]];
  }

  static d00.WordNScore getDefUniCandidate(int n) {
    if (n < 0 || n >= defUniqueLen) {
      throw 'RangeError: use "defUniqueLen" property';
    }
    return scoreWord_s[defUnique[n]];
  }
}

void main() {
  //step_00.getTop(9).forEach(print);

  GameStep step_01 = GameStep.next(
    null, 
    [
      (chr: 'e', clr: Clr.yellow),
      (chr: 'a', clr: Clr.grey),
      (chr: 'r', clr: Clr.yellow),
      (chr: 't', clr: Clr.yellow),
      (chr: 'h', clr: Clr.yellow)
    ],
  );

  var foo = List.generate(step_01.anyLen, (idx) => idx);
  for (var el in foo) {print(step_01.getAnyCandidate(el));}
  print('+++');
  var bar = List.generate(step_01.uniqueLen, (idx) => idx);
  for (var el in bar) {print(step_01.getUniCandidate(el));}

  //step_01.getUniCandidate(100);
}
