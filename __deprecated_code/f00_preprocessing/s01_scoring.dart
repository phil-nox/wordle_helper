import 'dart:io';
import 'dart:collection';
import 'dart:math';
import 'tmp01_len_five_word_s.dart' as tmp01;

void main() {
  const String                outputFilePath = './tmp02_score_len_five_word.dart';

  final Set<String>           alphabet = Set.from('abcdefghijklmnopqrstuvwxyz'.split(''));
  SplayTreeMap<String, int>   charToFreq = SplayTreeMap.from({for (String char in alphabet) char: 0});
  
  int                         baseValFreq = 0;
  int                         baseValScore = 0;

  List<({
    int score,
    int frequency, 
    String word,
  })>                         scoreWord_s= [];

  List<String>                outStr = [];
  final File                  outFile = File(outputFilePath);
  final IOSink                sinkOut = outFile.openWrite();
  

  for (({int frequency, String word}) elem in tmp01.lenFiveWord_s) {
    for (String char in elem.word.split('')) {
      if (!charToFreq.containsKey(char)) {
        continue;
      }
      charToFreq[char] = charToFreq[char]! + elem.frequency;
    }
  }

  baseValFreq = charToFreq.values.reduce(min) - 1;
  for (String key in charToFreq.keys) {
    charToFreq[key] = charToFreq[key]! - baseValFreq;
  }

  for (({int frequency, String word}) elem in tmp01.lenFiveWord_s) {
    int curScore = 0;
    for (String char in elem.word.split('')) {
      curScore += charToFreq[char] ?? 0;
    }
    scoreWord_s.add((score: curScore, frequency: elem.frequency, word: elem.word));
  }
  scoreWord_s.sort((a, b) {
    if (b.score.compareTo(a.score) == 0) {
      return b.frequency.compareTo(a.frequency);
    }
    return b.score.compareTo(a.score);
  }); // reversed

  baseValScore = scoreWord_s.last.score - 1;
  for (int idx = 0; idx < scoreWord_s.length; ++idx) {
    var elem = scoreWord_s[idx];
    scoreWord_s[idx] = (
      score: elem.score - baseValScore,
      frequency: elem.frequency,
      word: elem.word
    );
  }

  outStr.add('const List<({int score, int frequency, String word,})> scoreWord_s = [',);
  for (var elem in scoreWord_s) {
    outStr.add('  (score: ${elem.score}, frequency: ${elem.frequency}, word: "${elem.word}",),');
  }
  outStr.add('];\n');

  sinkOut.write(outStr.join('\n'));
  sinkOut.close();
}