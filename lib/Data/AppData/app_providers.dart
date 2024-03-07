import 'package:dummy/Application/Services/ApiServices/Apis.dart';
import 'package:dummy/Data/DataSource/Repository/Auth/auth_repo.dart';
import 'package:dummy/Presentation/Widgets/Auth/Login/Controllers/login_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> appProviders = [
  BlocProvider(
    create: (context) => LoginCubit(AuthRepository(APIs())),
  ),
];
