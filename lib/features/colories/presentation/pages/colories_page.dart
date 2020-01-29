import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_health_controller/features/account/presentation/bloc/bloc.dart';
import 'package:flutter_health_controller/features/colories/presentation/bloc/bloc.dart';

class ColoriesPage extends StatelessWidget {
  ColoriesPage();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountInitialized) {
                return Column(
                  children: <Widget>[
                    Icon(
                      Icons.accessibility_new,
                      size: 196.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    if (state.account.height != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Ваш рост: ${state.account.height}см',
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (state.account.weight != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Ваш вес: ${state.account.weight}кг',
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    (state.account.weight != null && state.account.height != null)
                        ? Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: RaisedButton(
                              child: Text('Проверить вес'),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BlocProvider(
                                        create: (ctx) => ColoriesBloc()
                                          ..add(CalculateColories(
                                            personHeight: state.account.height, // int.parse(heightController.text),
                                            personWeight: state.account.weight, // int.parse(weightController.text),
                                          )),
                                        child: BlocBuilder<ColoriesBloc, ColoriesState>(
                                          builder: (ctx, state) {
                                            if (state is ColoriesCalculated) {
                                              BlocProvider.of<AccountBloc>(context)
                                                  .add(AddWeightStatistic(calculatedWeight: state.colories));

                                              return SimpleDialog(
                                                title: const Text('Ваш результат!'),
                                                contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 16.0),
                                                children: <Widget>[
                                                  Text('Результат: ${state.colories.toStringAsFixed(2)}'),
                                                  Text(state.result),
                                                ],
                                              );
                                            }

                                            if (state is ColoriesError) {
                                              return SimpleDialog(
                                                title: const Text('Что-то пошло не так!'),
                                                contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 16.0),
                                                children: <Widget>[
                                                  Text(state.message),
                                                ],
                                              );
                                            }

                                            return SimpleDialog(
                                              title: const Text('Идёт подсчёт результата...'),
                                              children: <Widget>[
                                                Center(
                                                  child: Container(
                                                    width: 45,
                                                    height: 45,
                                                    margin: const EdgeInsets.all(10),
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );

                                  _formKey.currentState.reset();
                                }
                              },
                            ),
                          )
                        : Text(
                            'Заполните профиль в настройках',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                  ],
                );
              }

              return Center(
                child: Text(
                  'Пожалуйста, заполните информацию о себе!',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
