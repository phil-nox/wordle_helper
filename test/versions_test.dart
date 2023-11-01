// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:wordle_helper/main.dart' as mn;

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:convert/convert.dart';
import 'dart:convert';


void main() {
  test('Check version of the code', () {
    const String checkSum = '494139e0bfb314f5c330680fb5033bd171e0d21b';

    final targetDir = Directory('./lib');

    const Set<String> toIgnore = {
      './lib/.DS_Store',
    };

    List<FileSystemEntity> context = targetDir.listSync(recursive: false,);
    context.removeWhere((el) => toIgnore.contains(el.path));
    context.sort((cur, nxt) => cur.path.compareTo(nxt.path));

    AccumulatorSink<Digest> output = AccumulatorSink<Digest>();
    ByteConversionSink      input = sha1.startChunkedConversion(output);

    for (File file in context.whereType<File>()) {
      input.add(file.readAsBytesSync());
    }
    input.close();
    
    var digest = output.events.single.toString();
    expect(
      digest,
      checkSum,
      reason: '''👉 Update a version of code in "main.dart" & then checkSum in this test
      $checkSum corresponds to ${mn.codeVesrion}'''
    );
  });

}
