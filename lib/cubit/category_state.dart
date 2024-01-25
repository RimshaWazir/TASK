import 'package:dummy/Domain/Model/category_model.dart';

abstract class CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  CategoryError();
}
