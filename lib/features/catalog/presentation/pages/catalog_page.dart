import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_controller/features/catalog/presentation/pages/catalog_details_page.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';

class CatalogPage extends StatelessWidget {
  CatalogPage();

  final TextEditingController foodSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CatalogBloc>(
      create: (context) => sl<CatalogBloc>(),
      child: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          /* return ListView.builder(
            padding: const EdgeInsets.all(8),
            // itemCount: entries.length,
            // itemBuilder: (BuildContext context, int index) => CatalogList(entries[index]),
          ); */

          if (state is CatalogLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CatalogError) {
            return Center(
              child: RaisedButton(
                onPressed: () {
                  BlocProvider.of<CatalogBloc>(context).add(NavigationComplete());
                },
                child: Text('Попробовать ещё раз'),
              ),
            );
          }

          if (state is CatalogLoaded) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatalogDetailsPage(state.foodData),
                ),
              );
              BlocProvider.of<CatalogBloc>(context).add(NavigationComplete());
            });
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Поиск',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Название продукта'),
                        controller: foodSearchController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RaisedButton(
                        onPressed: () {
                          BlocProvider.of<CatalogBloc>(context).add(GetFood(name: foodSearchController.text));
                        },
                        child: Text('Найти'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
