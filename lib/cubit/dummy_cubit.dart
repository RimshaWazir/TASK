import 'package:dummy/Repository/dummy_repo.dart';

import 'package:dummy/cubit/dummy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DummyCubit extends Cubit<DummyState> {
  final DummyRepository repository;
  DummyCubit(this.repository) : super(CategoryLoading());

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
