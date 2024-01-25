import 'package:dummy/Data/DataSource/Repository/category_repo.dart';

import 'package:dummy/cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository repository;
  CategoryCubit(this.repository) : super(CategoryLoading());

  fetchCategories() async {
    await Future.delayed(Duration.zero);
    emit(CategoryLoading());
    try {
      var categories = await repository.fetchData();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError());
    }
  }
}
