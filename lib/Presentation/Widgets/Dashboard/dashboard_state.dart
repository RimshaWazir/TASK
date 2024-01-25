abstract class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoaded extends DashboardState {}

final class DashboardError extends DashboardState {
  final String? e;
  DashboardError({this.e});
}
