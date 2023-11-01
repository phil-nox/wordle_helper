import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'v00_core.dart' as v00;            // view_00
import 'v01_candidates.dart' as v01;      // view_01
import 'v02_stepscontrol.dart' as v02;    // view_02

import 'm00_game.dart' as m00;            // model_01
import 'm01_word.dart' as m01;            // model_00

const String codeVesrion = '0.1.0';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<m01.TheWord>(create: (context) => m01.TheWord()),
        ChangeNotifierProvider<m00.TheGame>(create: (context) => m00.TheGame()),
      ],
      child: MaterialApp(
        title: 'wordle_solver',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'RobotoMono',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

// Shortcuts ##################################################################
class AlphabetCharIntent extends Intent {
  const AlphabetCharIntent(this.char);

  final String char;
}


class AlphabetAction extends Action<AlphabetCharIntent> {
  AlphabetAction(this.theWordModel);

  final m01.TheWord theWordModel;

  @override
  void invoke(covariant AlphabetCharIntent intent) {
    theWordModel.alphabetInput(intent.char);
  }
}
// Shortcuts_end ##############################################################

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Row shiftedText({double shift = 25.0, required String text}) {
    return Row(children: [SizedBox(width: shift,), SelectableText(text,),],);
  }
    
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var theWord = context.watch<m01.TheWord>();
    var theGame = context.watch<m00.TheGame>();

    SizedBox theGridView = v00.CoreView.theWordAndStep_s(
      gameModel: theGame,
      wordModelNControl: theWord.charNClr_s.asMap().entries.map((el) => (
        chr: el.value.chr,
        clr: el.value.clr,
        onPressControl: () => theWord.toggleColor(el.key),
      )).toList(),
    );

    SizedBox theCandidateView = v01.CandidatesView.create(
      height: theGridView.height,
      width: 220.0,
      onPressedWithStrControl: (wordFromButton) => theWord.setTheWord(wordFromButton),
      candidateFuncAndLimit: theGame.candidateFuncAndLimit
    );

    SizedBox stepControl = v02.GameControlView.create(
      stepBack: theGame.step_s.isEmpty ? null : () {
        theGame.back();
      },
      fullBack: theGame.step_s.isEmpty ? null : () {
        theGame.clear();
      },
      stepForward: theWord.theWordisNotValid ? null : () {
        theGame.addStep(theWord.charNClr_s);
        theWord.setDefault();
      },
    );

    SizedBox wordControl = SizedBox(
      child: SegmentedButton(
        segments: const <ButtonSegment<m00.CandidateType>>[
          ButtonSegment<m00.CandidateType>(value: m00.CandidateType.anyChar,    label: Text('any')),
          ButtonSegment<m00.CandidateType>(value: m00.CandidateType.uniqueChar, label: Text('unique')),
        ],
        selected: {theGame.candidateType},
        onSelectionChanged: (Set<m00.CandidateType> newSelect) => theGame.selectCandidateType(newSelect),
        showSelectedIcon: false,
      ),
    );

    return Shortcuts(
      /*
      shortcuts: <ShortcutActivator, Intent>{
        LogicalKeySet(LogicalKeyboardKey(97)): const AlphabetCharIntent('a'),
        LogicalKeySet(LogicalKeyboardKey.keyB): const AlphabetCharIntent('b'),
      },
      */
      shortcuts: {
        for (int asciiNum in List<int>.generate(26, (int i) => 97 + i, growable: false))  // man ascii | 97 - a
          LogicalKeySet(LogicalKeyboardKey(asciiNum)): AlphabetCharIntent(String.fromCharCode(asciiNum))
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          AlphabetCharIntent: AlphabetAction(theWord),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            body: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(  // https://stackoverflow.com/a/57539405
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    // color: Colors.amber,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shiftedText(text: 'wordle_helper'),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: theme.colorScheme.outline,),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    theGridView,                                                // 👀                   
                                    const SizedBox(height: 30,),
                                    stepControl,                                                // 👀  
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    theCandidateView,                                           // 👀    
                                    const SizedBox(height: 30,),
                                    wordControl,                                                // 👀
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //shiftedText(text: 'data_source:  https://www.nytimes.com/games-assets/v2/wordle.0184c33d9a3561750c6f.js'),
                        shiftedText(text: 'code_version: $codeVesrion'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
