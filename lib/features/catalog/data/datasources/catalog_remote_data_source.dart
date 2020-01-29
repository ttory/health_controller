import 'package:meta/meta.dart';

import '../../../../core/client/request_edamam.dart';
import '../../../../core/client/request_pixels.dart';
import '../../../../core/error/exceptions.dart';
import '../models/food_model.dart';

abstract class CatalogRemoteDataSource {
  /// Calls the Recipe endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<FoodModel> getFoodsByName(String name);
}

class CatalogRemoteDataSourceImpl implements CatalogRemoteDataSource {
  final RequestEdamam clientEdamam;
  final RequestPixels clientPixels;

  CatalogRemoteDataSourceImpl({@required this.clientEdamam, @required this.clientPixels});

  @override
  Future<FoodModel> getFoodsByName(String name) async {
    final response = await clientEdamam.get('api/food-database/parser', params: {
      'app_id': 'edd003f2',
      'app_key': 'eb267be54a9c28d70f4676f29d5e890c',
      'ingr': name,
    });

print("response!");
print(response);

    if (response.statusCode == 200) {
      final data = response.data['parsed'] as List;

      if (data.isNotEmpty) {
        final responseImg = await clientPixels.get('v1/search', params: {
          'query': data.first['food']['label'],
          'per_page': '1',
          'page': '1',
        });

        String imageUrl = 'https://images.pexels.com/photos/479453/pexels-photo-479453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=450&w=720';

        if (responseImg.statusCode == 200) {
          final imgData = responseImg.data['photos'] as List;

          if (imgData.isNotEmpty) {
            imageUrl = imgData.first['src']['medium'];
          }
        } else {
          //! Implement
          throw ServerException();
        }

        final parsedData = data.first['food'];

        //! Catch errors if not in json?
        final FoodModel foodData = FoodModel(
          id: parsedData['foodId'],
          label: parsedData['label'],
          colories: double.tryParse(parsedData['nutrients']['ENERC_KCAL'].toString()) ?? 0.0,
          category: parsedData['category'],
          imageUrl: imageUrl,
        );

        print(parsedData['nutrients']['ENERC_KCAL']);

        return foodData;
      } else {
        //! Implement
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
