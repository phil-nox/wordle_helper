import 'dart:io';
import 'tmp02_score_len_five_word.dart' as tmp02;

void main() {
  const String                outputFilePath = './tmp03_unique_five_filter.dart';
  
  List<int> uniqueFive = [];

  List<String>                outStr = [];
  final File                  outFile = File(outputFilePath);
  final IOSink                sinkOut = outFile.openWrite();


  for (int idx = 0; idx < tmp02.scoreWord_s.length; ++idx) {
    if (Set.from(tmp02.scoreWord_s[idx].word.split('')).length == 5) {
      uniqueFive.add(idx);
    }
  }

  outStr.add('final List<int> uniqueFive = ${uniqueFive.toString()};\n',);
  sinkOut.write(outStr.join('\n'));
  sinkOut.close();
 }