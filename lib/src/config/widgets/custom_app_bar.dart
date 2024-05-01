import '../index.dart';
import 'package:flutter/cupertino.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? backCallback;
  final bool showTrailing;
  final Widget? trailing;
  final bool addBackButton;
  final Widget? bottom;
  const CustomAppBar({
    super.key,
    required this.title,
    this.backCallback,
    this.showTrailing = true,
    this.trailing,
    this.addBackButton = true,
    this.bottom,
  });

  @override
  Size get preferredSize => Size.fromHeight(bottom != null ? (kToolbarHeight * 2) : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: _Title(title: title),
      leading: addBackButton ? _Back(backCallback: backCallback) : null,
      actions: [
        ...showTrailing
            ? [
                ...trailing != null ? [trailing!] : [],
              ]
            : [],
      ],
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: preferredSize,
              child: bottom!,
            )
          : null,
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16.sp,
      ),
    );
  }
}

class _Back extends StatelessWidget {
  final VoidCallback? backCallback;
  const _Back({
    required this.backCallback,
  });
  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return CupertinoButton(
      padding: const EdgeInsets.all(0.0),
      onPressed: backCallback ??
          () {
            router.popRoute();
          },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: const Icon(
          Icons.arrow_back,
          size: 22,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}
