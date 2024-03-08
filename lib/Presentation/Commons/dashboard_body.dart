import '../../Data/DataSource/Resources/imports.dart';

class DashboardBody extends StatelessWidget {
  DashboardCubitLoaded state;
  DashboardBody({
    super.key,
    required this.cubit,
    required this.state,
  });

  final DashboardCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            HomeAppBar(),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.verticalSpace(24),
            Text(
              AppStrings.recently,
              style: TextStyles.urbanistLar(
                context,
              ),
            ),
            Gap.verticalSpace(24),
            AvatarUserList(images: cubit.images, names: cubit.names),
            Text(
              AppStrings.messages,
              style: TextStyles.urbanistLar(
                context,
              ),
            ),
            StreamBuilder(
                stream: APIs().getAllUsers(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    // If data loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());
                    // If data load
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (state.user.isNotEmpty) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.user.length,
                            itemBuilder: (context, index) {
                              return ChatCard(user: state.user[index]);
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(AppStrings.noUserFound),
                        );
                      }
                  }
                })
          ],
        ),
      ),
    );
  }
}
