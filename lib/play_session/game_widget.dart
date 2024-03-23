import 'package:basic/Components/NeuBox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/level_state.dart';
import '../level_selection/levels.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final level = context.watch<GameLevel>();
    final levelState = context.watch<LevelState>();
    final fontConfig = GoogleFonts.montserrat(fontSize: 13);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Drag the slider to ${level.difficulty}% or above!'),
        Slider(
          label: 'Level Progress',
          autofocus: true,
          value: levelState.progress / 100,
          onChanged: (value) => levelState.setProgress((value * 100).round()),
          onChangeEnd: (value) {
            context.read<AudioController>().playSfx(SfxType.wssh);
            levelState.evaluate();
          },
        ),
        Column(
          children: [
            Row(
              children: ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P']
                  .map((key) => Neubox(children: Text(key, style: fontConfig)))
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L']
                  .map((key) => Neubox(children: Text(key, style: fontConfig)))
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [' ⌫ ', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'Enter']
                  .map((key) => Neubox(children: Text(key, style: fontConfig)))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}
