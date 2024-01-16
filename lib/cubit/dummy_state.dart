import 'package:dummy/Model/dummy_model.dart';

abstract class DummyState {}

class CategoryLoading extends DummyState {}

class CategoryLoaded extends DummyState {
  final List<DummyModel> categories;
  CategoryLoaded(this.categories);
}

class CategoryError extends DummyState {
  CategoryError();
}
