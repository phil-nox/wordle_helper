import 'package:flutter/material.dart';


import 'l00_local_back.dart' as l00;                      // local_back_00

import 'm00_game.dart' as m00;
import 'm01_word.dart' as m01;

class CoreView {

  static const Map<l00.Clr, Color> gClr2RealClr = {        // game_model_color_2_real_view_color
      l00.Clr.none: Color.fromARGB(255, 255, 0, 255),
      l00.Clr.grey: Color.fromARGB(255, 121, 124, 126),
      l00.Clr.yellow: Color.fromARGB(255, 197, 181, 102),
      l00.Clr.green:  Color.fromARGB(255, 121, 168, 107),
  };

  static const emptyBorderClr = Color.fromARGB(255, 224, 224, 224);

  static const double radiusOfChar = 30.0;
  static const double sizeOfGap = 10.0;


  static Row wordInStep(
    List<({String chr, l00.Clr clr})> word,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        word.length * 2 - 1,                        // [button, sizebox, button ..., button]
        (int idx) {
          switch (idx % 2) {
            case 0:
              return ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    fixedSize: const Size.fromRadius(radiusOfChar),
                    disabledBackgroundColor: gClr2RealClr[word[idx ~/ 2].clr],
                    disabledForegroundColor: Colors.black,
                  ),
                  child: Text(word[idx ~/ 2].chr),
              );
            default:
              return const SizedBox(width: sizeOfGap);     // Width
          }
        }
      ),
    );
  }

  static Row emptyStep({required int lenOfrow}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        lenOfrow * 2 - 1,                           // [button, sizebox, button ..., button]
        (int idx) {
          switch (idx % 2) {
            case 0:
              return ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    fixedSize: const Size.fromRadius(radiusOfChar),
                    side: const BorderSide(color: emptyBorderClr, width: 2),
                    disabledBackgroundColor: Colors.white,
                  ),
                  child: const Text(''),
              );
            default:
              return const SizedBox(width: sizeOfGap);     // Width
          }
        }
      ),
    );
  }

  static List<Widget> allStep_s({
    required m00.TheGame gameModel,
  }) {
    return List<Widget>.generate(
      m00.TheGame.defNumOfStep_s * 2 - 1,                           // [row, sizebox, row, ..., row]
      (int idx) {
        switch (idx % 2) {
          case 0:
            return idx ~/ 2 < gameModel.step_s.length ? 
                      wordInStep(gameModel.step_s[idx ~/ 2].word) 
                    : emptyStep(lenOfrow: m00.TheGame.defWordLen);
          default:
            return const SizedBox(height: sizeOfGap);      // Height
        }
      },
    );
  }

  static Row currentWord (
    List<({String chr, l00.Clr clr, VoidCallback? onPressControl})> word,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        word.length * 2 - 1,                        // [button, sizebox, button ..., button]
        (int idx) {
          switch (idx % 2) {
            case 0:
              return ElevatedButton(
                  onPressed: word[idx ~/ 2].onPressControl,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    fixedSize: const Size.fromRadius(radiusOfChar),
                    backgroundColor: gClr2RealClr[word[idx ~/ 2].clr],
                    foregroundColor: Colors.black,
                  ),
                  child: Text(word[idx ~/ 2].chr),
              );
            default:
              return const SizedBox(width: sizeOfGap);     // Width
          }
        }
      ),
    );
  }

  static SizedBox theWordAndStep_s ({
    required m00.TheGame gameModel,
    required List<({String chr, l00.Clr clr, VoidCallback? onPressControl})> wordModelNControl,
  }) {
    return SizedBox(
      height: m00.TheGame.defNumOfStep_s * (radiusOfChar * 2 + sizeOfGap) + radiusOfChar * 2,
      width: m00.TheGame.defWordLen * (radiusOfChar * 2 + sizeOfGap) - sizeOfGap,
      child: Column(
        children: [
          ...CoreView.allStep_s(gameModel: gameModel),
          const SizedBox(height: sizeOfGap),
          CoreView.currentWord(wordModelNControl),
        ],
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
  runApp(const NotProdView());
}

class NotProdView extends StatefulWidget {
  const NotProdView({super.key});

  @override
  State<NotProdView> createState() => _NotProdViewState();
}

class _NotProdViewState extends State<NotProdView> {
  final notProdgameModel = m00.notForProd();
  final notProdwordModel = m01.notForProd();

  @override
  Widget build(BuildContext context) {

    final theGoal = CoreView.theWordAndStep_s(    // 🎯
    gameModel: notProdgameModel,
    wordModelNControl: notProdwordModel.charNClr_s.asMap().entries.map((el) => (
        chr: el.value.chr,
        clr: el.value.clr,
        onPressControl: () {setState(() {notProdwordModel.toggleColor(el.key);});},
      )).toList(),
    );


    return MaterialApp(
      title: 'not_the_app',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Card(
                    //color: const Color.fromARGB(255, 255, 0, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text('StepsToView.wordInStep'),
                          CoreView.wordInStep(                           // 👀
                            [
                              (chr: '1', clr: l00.Clr.green,),
                              (chr: '2', clr: l00.Clr.grey,),
                              (chr: '3', clr: l00.Clr.yellow,),
                              (chr: '4', clr: l00.Clr.grey,),
                              (chr: '5', clr: l00.Clr.grey,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Card(
                    //color: const Color.fromARGB(255, 255, 0, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text('StepsToView.emptyStep'),
                          CoreView.emptyStep(lenOfrow: 5),                // 👀  
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Card(
                    //color: const Color.fromARGB(255, 255, 0, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text('StepsToView.currentWord'),
                          CoreView.currentWord(                          // 👀
                            [
                              (chr: 'e', clr: l00.Clr.green, onPressControl: () => print('0')),
                              (chr: 'a', clr: l00.Clr.grey, onPressControl: () => print('1')),
                              (chr: 'r', clr: l00.Clr.green, onPressControl: () => print('2')),
                              (chr: 't', clr: l00.Clr.grey, onPressControl: () => print('3')),
                              (chr: 'h', clr: l00.Clr.yellow, onPressControl: () => print('4')),
                            ],
                          ),                
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10,),
              Column(
                children: [
                  Card(
                    //color: const Color.fromARGB(255, 255, 0, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text('StepsToView.allStep_s'),          // 👀
                          ...CoreView.allStep_s(gameModel: notProdgameModel),            
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10,),
              Column(
                children: [
                  Card(
                    //color: const Color.fromARGB(255, 255, 0, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text('StepsToView.viewOfwordNstep_s'),
                          Text('${theGoal.height} x ${theGoal.width}'),
                          theGoal,                                            // 👀 🎯
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


