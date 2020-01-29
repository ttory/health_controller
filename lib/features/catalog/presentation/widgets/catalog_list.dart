import 'package:flutter/material.dart';
import 'package:flutter_health_controller/features/catalog/data/models/food_model.dart';

import 'package:flutter_health_controller/features/catalog/presentation/pages/catalog_details_page.dart';

class CatalogList extends StatelessWidget {
  CatalogList(this.data);

  final FoodModel data;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CatalogDetailsPage(data),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Image.network(
              data.imageUrl,
              height: 175,
              width: double.infinity,
              cacheHeight: 125,
              fit: BoxFit.cover,
              gaplessPlayback: true,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 175,
                  width: double.infinity,
                  color: Colors.grey[200],
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              height: 65,
              child: Text(
                data.label,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
