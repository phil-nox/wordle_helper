import 'package:flutter/material.dart';
import 'd00_word_score_s.dart' as d00;
import 'm00_game.dart' as m00;

class CandidatesView {

  static const double sizeOfGap = 10.0;

  static SizedBox create ({
    required Function(String wordFromButton) onPressedWithStrControl,
    required ({d00.WordNScore Function(int) func, int limit}) candidateFuncAndLimit,
    double? height,
    double? width,
  }) {
    if (candidateFuncAndLimit.limit == 0) {
      return SizedBox(
        height: height,
        width: width,
        child: const Icon(Icons.search_off_outlined),
      );
    }

    return SizedBox(
        height: height,
        width: width,
        child: ListView.separated(
          padding: const EdgeInsets.all(sizeOfGap),
          reverse: true,
          itemCount: candidateFuncAndLimit.limit,
          itemBuilder: (BuildContext context, int idx) {
            
            d00.WordNScore candidate = candidateFuncAndLimit.func(idx);
            
            String rank = ((idx + 1) % 100).toString().padLeft(2, '0');
            rank = (idx + 1) ~/ 100 == 0 ? ' $rank' : '.$rank';

            return ElevatedButton(
              onPressed: () => onPressedWithStrControl(candidate.word),
              child: Padding(
                padding: const EdgeInsets.all(sizeOfGap),
                child: Text.rich(
                  TextSpan(
                    children: [
                        TextSpan(text: rank),
                        TextSpan(text: ' ${candidate.word}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int idx) => const SizedBox(height: sizeOfGap,),
        ),
    );
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


void main() {
  runApp(const PartsTest());
}

class PartsTest extends StatelessWidget {
  const PartsTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'not_the_app',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'RobotoMono',
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            color: Colors.amber,
            padding: const EdgeInsets.all(10),
            child: CandidatesView.create(
              height: 480,
              width: 250,
              onPressedWithStrControl: (e) => print(e),
              candidateFuncAndLimit: m00.TheGame().candidateFuncAndLimit,
            ),
          ),
        ),
      ),
    );
  }
}


