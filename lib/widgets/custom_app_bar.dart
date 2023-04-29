import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title="PayeTonKawa", required this.isAuthent});
  final String title;
  final bool isAuthent;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      actions: 
      (isAuthent)
      ? <Widget>[
        IconButton(
          onPressed: () {
            
          }, 
          icon: const Icon(
            Icons.print
          ),
        ),
      ]
      : null
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}