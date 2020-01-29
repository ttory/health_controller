import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ColoriesBloc extends Bloc<ColoriesEvent, ColoriesState> {
  @override
  ColoriesState get initialState => ColoriesUninitialized();

  @override
  Stream<ColoriesState> mapEventToState(ColoriesEvent event) async* {
    final currentState = state;

    if (event is CalculateColories) {
      try {
        final height = event.personHeight * 0.01;
        final double colories = event.personWeight / (height * height);

        if (colories == double.infinity || colories == double.nan || colories < 1 || colories > 200) {
          throw Exception();
        }

        String result;
        if (colories <= 18.5) {
          result = 'У Вас недостаточный вес!';
        } else if (colories > 18.5 && colories <= 25) {
          result = 'У Вас нормальный вес!';
        } else if (colories > 25) {
          result = 'У Вас ожирение!';
        }

        yield ColoriesCalculated(colories: colories, result: result);
      } catch (e) {
        yield ColoriesError(message: '''Похоже, что Вы ошиблись при вводе, или Вы не с этой планеты...

        (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧
        ''');
      }
    }
  }
}
