import 'package:dummy/Repository/dummy_repo.dart';
import 'package:dummy/cubit/dummy_event.dart';
import 'package:dummy/cubit/dummy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final DummyRepository repository;

  CategoryBloc(this.repository) : super(CategoryLoading()) {
    on<FetchCategories>((event, emit) async {
      try {
        var categories = await repository.fetchData();
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(CategoryError());
      }
    });
  }
}
