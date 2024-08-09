import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Your App'),
      actions: <Widget>[
        // Add any navigation actions here
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
