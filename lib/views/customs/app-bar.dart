import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  final Color backgroundColor;
  final Color titleColor;
  final String title;
  final bool withBackButton;
  final PreferredSizeWidget bottom;
  const CustomAppbar({Key key, this.title, this.backgroundColor, this.titleColor, this.withBackButton : false, this.bottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      centerTitle: true,
      leading: withBackButton ? BackButton() : Container(),
      title: Text(
        title,
      ),
      bottom: bottom,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);


}


class BackButton extends StatelessWidget {
  const BackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.keyboard_arrow_down));
  }
}

