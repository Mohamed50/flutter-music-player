import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  final Color backgroundColor;
  final Color titleColor;
  final String title;
  const CustomAppbar({Key key, this.title, this.backgroundColor, this.titleColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      foregroundColor: Colors.blue,
      centerTitle: true,
      leading: Icon(Icons.keyboard_arrow_down, color: titleColor,),
      title: Text(
        title,
        style: TextStyle(
            color: titleColor
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}
