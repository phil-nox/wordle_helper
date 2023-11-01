import 'dart:io';

void main(List<String> arguments) {

  // Paths of file_s in this script are according run cmd: 'dart run ./s00_read_file.dart'
  const String                          inputFilePath = './tmp00_word_freqiency.txt';
  const String                          outputFilePath = './tmp01_len_five_word_s.dart';

  final File                            inFile = File(inputFilePath);
  final List<String>                    line_s = inFile.readAsLinesSync();

  final Set<String>                     alphabet = Set.from('abcdefghijklmnopqrstuvwxyz'.split(''));
  List<({int frequency, String word})>  lenFiveWord_s = [];
  List<String>                          outStr = [];
  
  final File                            outFile = File(outputFilePath);
  final IOSink                          sinkOut = outFile.openWrite();
  
  while (line_s.isNotEmpty && line_s.last == '') {                              //  + - remove empty line_s from end
    line_s.removeLast();                                                        //  |
  }                                                                             //  |

  for (String line in line_s) {                                                 //  + - create a list_record_s
    List<String> part_s = line.split('\t');                                     //  |   '\t' 👀
    Set<String> char_s = Set.from(part_s[0].split(''));                         //  |
    if (part_s[0].length != 5) { continue; }                                    //  |   skip 'now' or 'things'
    if (part_s[1].length < 5) { continue; }                                     //  |   5    👀
    if (!alphabet.containsAll(char_s)) { continue; }                            //  |   skip 'week-'

    lenFiveWord_s.add((frequency: int.parse(part_s[1]), word: part_s[0]));      //  |
  }

  outStr.add("const List<({int frequency, String word,})> lenFiveWord_s = [",); //  + - transfert list_record_s to String 
  for (({int frequency, String word}) el in lenFiveWord_s) {                    //  |   to write to outFile
    outStr.add('  (frequency: ${el.frequency}, word: "${el.word}"),');          //  |
  }                                                                             //  |
  outStr.add("];\n");                                                           //  |

  sinkOut.write(outStr.join('\n'));                                             //  + - writing 
  sinkOut.close();                                                              //  |

  int widthForVerbose = line_s.length.toString().length;
  String verbosePass = lenFiveWord_s.length.toString().padLeft(widthForVerbose);
  String verboseTotal = line_s.length.toString();

  print('$verboseTotal words total');
  print('$verbosePass words pass');
}