import 'package:flutter/material.dart';
import '../../res/size_configs.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      centerTitle: true,
      leading: GestureDetector(
        onTap: ()=> Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          size: 6 * SizeConfigs.imageSizeMultiplier,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
