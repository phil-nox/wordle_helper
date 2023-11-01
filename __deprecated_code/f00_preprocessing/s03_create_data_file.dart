import 'dart:io';

void main() {
  List<File>                  input_s = [
                                          File('tmp02_score_len_five_word.dart'),
                                          File('tmp03_unique_five_filter.dart')
                                        ];
  const String                outputFilePath = '../d00_scores_freq_words.dart';

  List<String>                outStr = [];
  final File                  outFile = File(outputFilePath);
  final IOSink                sinkOut = outFile.openWrite();

  for (File el in input_s) {
    outStr.add(el.readAsStringSync());
  }

  sinkOut.write(outStr.join('\n'));
  sinkOut.close();
 }