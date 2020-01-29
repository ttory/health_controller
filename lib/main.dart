import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_controller/features/account/presentation/bloc/bloc.dart';
import 'package:flutter_health_controller/features/account/presentation/pages/account_page.dart';
import 'package:flutter_health_controller/features/catalog/presentation/pages/catalog_page.dart';
import 'package:flutter_health_controller/features/colories/presentation/pages/colories_page.dart';
import 'package:flutter_health_controller/features/statistic/presentation/pages/statistic_page.dart';
import 'package:flutter_health_controller/simple_hydrated_bloc_delegate.dart';

import 'injection_container.dart' as di;

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = await SimpleHydratedBlocDelegate.build();
  runApp(App());
}

/// This Widget is the main application widget.
class App extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AccountBloc()..add(InitAccount()),
      child: MaterialApp(
        title: _title,
        home: TabsPage(),
      ),
    );
  }
}

class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 3;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    ColoriesPage(),
    CatalogPage(),
    StatisticPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colories counter'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new),
            title: Text('Подсчёт'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            title: Text('Каталог'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text('Статистика'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Аккаунт'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
