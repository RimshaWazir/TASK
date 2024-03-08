import 'dart:developer';
import '../../../Data/DataSource/Resources/imports.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: BlocConsumer<DashboardCubit, DashboardCubitState>(
          listener: (context, state) {
            if (state is DashboardCubitError) {
              Text(state.errorMessage);
            }
          },
          builder: (context, state) {
            log(state.toString());

            if (state is DashboardCubitInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardCubitLoaded) {
              final cubit = context.read<DashboardCubit>();
              return DashboardBody(cubit: cubit, state: state);
            } else {
              return const Center(
                child: Text("Something Went Wrong"),
              );
            }
          },
        ),
      ),
    );
  }
}

FirebaseAuth auth = FirebaseAuth.instance;
