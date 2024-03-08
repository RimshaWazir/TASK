import '../DataSource/Resources/imports.dart';

List<BlocProvider> appProviders = [
  BlocProvider<LoginCubit>(
    create: (BuildContext context) => LoginCubit(AuthRepository(APIs())),
  ),
  BlocProvider<DashboardCubit>(
    create: (BuildContext context) => DashboardCubit(auth),
  ),
];
