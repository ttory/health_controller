import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Food extends Equatable {
  final String id;
  final String label;
  final String imageUrl;
  final double colories;
  final String category;

  Food({
    @required this.id,
    @required this.label,
    @required this.imageUrl,
    @required this.colories,
    @required this.category,
  });

  @override
  List<Object> get props => [id, label, imageUrl, colories, category];

  @override
  String toString() => 'Food { id: $id, label: $label, imageUrl: $imageUrl, colories: $colories, category: $category }';
}
