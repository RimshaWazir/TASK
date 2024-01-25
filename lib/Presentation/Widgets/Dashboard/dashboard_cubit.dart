import 'package:dummy/Presentation/Widgets/Dashboard/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  loadData() async {
    await Future.delayed(Duration.zero);
    emit(DashboardInitial());
    print('cubit call');

    try {
      emit(DashboardLoaded());
    } catch (e) {
      emit(DashboardError(e: "Error"));
      rethrow;
    }
  }
}
