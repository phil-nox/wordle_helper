import 'dart:io';

import 's00_data.dart' as s00;


class WordNScore {
  final  String word;
  final double score;

  const WordNScore({required this.word, required this.score});

  @override
  String toString() {
    return "WordNScore(score: $score, word: '$word')";
  }
  
  static String str() {
    return 
"""
class WordNScore {
  final String word;
  final double score;
      
  const WordNScore({required this.word, required this.score});
      
  @override
  String toString() {
    return 'WordNScore(score: \$score, word: \$word)';
    }
}
""";
  }
}

void main() {
  const int wordLen = 5;
  final Set<String> alphabet = Set.from('abcdefghijklmnopqrstuvwxyz'.split(''));

  final Map<String, double> scale = {for (String el in alphabet) el: 0.0};
  for (String word in s00.wordleWord_s) {
    for (int i = 0; i < wordLen; ++i) {
      scale[word[i]] = scale[word[i]]! + 1.0;
    }
  }
  for (String key in scale.keys) {
    scale[key] = scale[key]! / s00.wordleWord_s.length;
  }

  List<WordNScore> rlt = [];
  List<int> unique = [];

  for (String word in s00.wordleWord_s) {
    double score = 0.0;
    for (String el in Set.from(word.split(''))) {
      score += scale[el]!;
    }
    rlt.add(WordNScore(score: score, word: word));
  }

  rlt.sort((el, nxt) => nxt.score.compareTo(el.score));
  for (int idx = 0; idx < rlt.length; ++idx) {
    if (Set.from(rlt[idx].word.split('')).length == 5) {
      unique.add(idx);
    }
  }
  
  const String                outputFilePath = '../lib/d00_word_score_s.dart';
  List<String>                outStr = [];
  final File                  outFile = File(outputFilePath);
  final IOSink                sinkOut = outFile.openWrite();


  outStr.add(WordNScore.str());
  outStr.add('const List<WordNScore> scoreWord_s = [');
  for (var el in rlt) {
    outStr.add('  $el,');
  }
  outStr.add('];\n');
  outStr.add('final List<int> unique = $unique;');

  sinkOut.write(outStr.join('\n'));
  sinkOut.close();
}
