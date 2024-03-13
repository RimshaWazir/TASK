import 'package:dummy/Presentation/Widgets/Auth/SignUp/Controller/sign_up_cubit.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/Messages/Controllers/message_cubit.dart';

import '../DataSource/Resources/imports.dart';

List<BlocProvider> appProviders = [
  BlocProvider<LoginCubit>(
    create: (BuildContext context) => LoginCubit(AuthRepository(APIs())),
  ),
  BlocProvider<DashboardCubit>(
    create: (BuildContext context) => DashboardCubit(auth),
  ),
  BlocProvider<SignUpCubit>(
    create: (BuildContext context) => SignUpCubit(AuthRepository(APIs())),
  ),
  BlocProvider<ChatCubit>(
    create: (BuildContext context) => ChatCubit(ChatUser()),
  )
];
