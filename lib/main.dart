import 'Data/DataSource/Resources/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    runApp(MultiBlocProvider(
      providers: appProviders,
      child: const MyApp(),
    ));
  });
}
