import 'package:flutter/material.dart';
import 'package:todo/styles/app_styles.dart';

class TodoAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TodoAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: OverflowBar(
        spacing: 23,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.book),
            label: Text('All'),
            style: AppStyles.appBarBtnStyle,
          ),
          TextButton.icon(
            onPressed: () {},
            label: Text("Done"),
            icon: Icon(Icons.check_box_outlined),
            style: AppStyles.appBarBtnStyle,
          ),
        ],
      ),

      actions: [
        TextButton(onPressed: () {}, style: AppStyles.appBarBtnStyle, child: Icon(Icons.settings)),
      ],
      centerTitle: true,
      elevation: 0,
      actionsPadding: EdgeInsets.only(right: 5),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
