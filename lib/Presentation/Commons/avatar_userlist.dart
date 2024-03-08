import '../../Data/DataSource/Resources/imports.dart';

class AvatarUserList extends StatelessWidget {
  const AvatarUserList({
    super.key,
    required this.images,
    required this.names,
  });

  final List<String> images;
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.16.sh,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.sp),
            child: Column(
              children: [
                SizedBox(
                  width: 60.h,
                  height: 60.w,
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.contain,
                  ),
                ),
                Gap.verticalSpace(5),
                Text(
                  names[index],
                  style: TextStyles.urbanistLar(context,
                      color: const Color(0xff171717), fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
