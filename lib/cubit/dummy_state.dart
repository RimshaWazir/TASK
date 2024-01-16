import 'package:dummy/Model/dummy_model.dart';

abstract class CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<DummyModel> categories;
  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  CategoryError();
}
