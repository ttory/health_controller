import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_controller/features/account/presentation/bloc/bloc.dart';
import 'package:intl/intl.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AccountBloc _accountBloc;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _weightGoalController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _accountBloc = BlocProvider.of<AccountBloc>(context);

    final currentState = _accountBloc.state;
    if (currentState is AccountInitialized) {
      _nameController = TextEditingController(text: currentState.account.name);
      _heightController = TextEditingController(text: currentState.account.height != null ? currentState.account.height.toString() : '');
      _weightController = TextEditingController(text: currentState.account.weight != null ? currentState.account.weight.toString() : '');
      _weightGoalController =
          TextEditingController(text: currentState.account.goalWeight != null ? currentState.account.goalWeight.toString() : '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountInitialized) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'О себе',
                      style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Укажите своё имя',
                        labelText: 'Имя',
                      ),
                      onChanged: (value) {
                        BlocProvider.of<AccountBloc>(context).add(SetName(name: value));
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, укажите своё имя';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 35,
                            height: 35,
                            margin: const EdgeInsets.only(right: 12.0),
                            child: RaisedButton(
                              color: Colors.amber,
                              onPressed: () async {
                                DateTime selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(1998),
                                  firstDate: DateTime(1951),
                                  lastDate: DateTime(2010),
                                );

                                if (selectedDate != null) {
                                  BlocProvider.of<AccountBloc>(context).add(SetBirthday(date: selectedDate));
                                }
                              },
                              padding: const EdgeInsets.all(0),
                              child: Icon(
                                Icons.date_range,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            state.account.birthday != null
                                ? DateFormat("dd.MM.yyyy").format(state.account.birthday).toString()
                                : 'Не указано',
                            style: TextStyle(fontSize: 18.0, color: Colors.amber[800]),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        hintText: 'Укажите свой рост',
                        labelText: 'Рост',
                      ),
                      onChanged: (value) {
                        BlocProvider.of<AccountBloc>(context).add(SetHeight(height: int.parse(value)));
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, укажите свой рост';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Укажите свой вес',
                              labelText: 'Вес',
                            ),
                            onChanged: (value) {
                              BlocProvider.of<AccountBloc>(context).add(SetWeight(weight: int.parse(value)));
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Пожалуйста, укажите свой текущий вес';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: _weightGoalController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Укажите желаемый вес',
                              labelText: 'Желаемый вес',
                            ),
                            onChanged: (value) {
                              BlocProvider.of<AccountBloc>(context).add(SetGoalWeight(weight: int.parse(value)));
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Пожалуйста, укажите желаемый вес';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    /*  Container(
                      margin: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20.0),
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.amber,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            print('Saved');
                          }
                        },
                        child: Text('Сохранить изменения'),
                      ),
                    ) */
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
