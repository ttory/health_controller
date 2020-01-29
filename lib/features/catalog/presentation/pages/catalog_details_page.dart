import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../account/presentation/bloc/bloc.dart';
import '../../data/models/food_model.dart';

class CatalogDetailsPage extends StatelessWidget {
  CatalogDetailsPage(this.data);

  final FoodModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                data.imageUrl,
                cacheHeight: 300,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey[200],
                  );
                },
              ),
              SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  data.category,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.blue,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                margin: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  data.label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Колорий: ${data.colories.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.0,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountInitialized && !state.account.contains(data)) {
            return FloatingActionButton(
              onPressed: () {
                BlocProvider.of<AccountBloc>(context).add(AddFoodStatistic(foodData: data));
              },
              tooltip: 'Добавить',
              child: Icon(Icons.add),
            );
          }

          return Container();
        },
      ),
    );
  }
}
