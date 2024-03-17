import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/config.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.actions,
    this.icon,
    this.route,
    this.appTitle,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(60); //default height of app bar 60

  final String? appTitle;
  final String? route;
  final IconData? icon; // Changed type to IconData
  final List<Widget>? actions;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        widget.appTitle!,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      leading: widget.icon != null
          ? Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Config.primaryColor,
              ),
              child: IconButton(
                onPressed: () {
                  if (widget.route != null && widget.route == 'doc_details') {
                    Navigator.of(context).pushReplacementNamed('/');
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                icon: Icon(widget.icon!),
                iconSize: 16,
                color: Colors.white,
              ),
            )
          : null,
      actions: widget.actions ?? null,
    );
  }
}
