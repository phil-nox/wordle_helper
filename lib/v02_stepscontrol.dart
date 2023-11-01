import 'package:flutter/material.dart';

class GameControlView {

  static const double sizeIconBut = 30;
  static const double sizeOfGap = 30;

  static SizedBox create({
    required void Function()? stepBack,
    required void Function()? fullBack,
    required void Function()? stepForward,
    double? width,  
    double? height,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton.filled(
            icon: const Icon(Icons.restore_page),
            onPressed: stepBack,
            iconSize: sizeIconBut,
          ),
          const SizedBox(width: sizeOfGap,),
          IconButton.filled(
            icon: const Icon(Icons.delete_forever),
            onPressed: fullBack,
            iconSize: sizeIconBut,
          ),
          const SizedBox(width: sizeOfGap,),
          IconButton.filled(
            icon: const Icon(Icons.task),
            onPressed: stepForward,
            iconSize: sizeIconBut,
          ),
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
  runApp(PartsTest());
}

class PartsTest extends StatelessWidget {
  const PartsTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'not_the_app',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: GameControlView.create(
              stepBack: () => print('undo'),
              fullBack: () => print('refresh'),
              stepForward: null,
              width: 400,
            ),
          ),
        ),
      ),
    );
  }
}


