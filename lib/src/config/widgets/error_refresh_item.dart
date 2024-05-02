import 'package:flutter/cupertino.dart';

class ErrorRefreshItem extends StatelessWidget {
  final String errorText;
  final VoidCallback? refresh;
  const ErrorRefreshItem({
    super.key,
    required this.errorText,
    this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        alignment: Alignment.center,
        child: CupertinoButton(
          padding: const EdgeInsets.all(0.0),
          onPressed: refresh != null
              ? () {
                  refresh!();
                }
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _Title(
                errorText: errorText,
              ),
              ...refresh != null
                  ? [
                      const SizedBox(height: 40),
                      const _Icon(),
                    ]
                  : [],
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String errorText;
  const _Title({
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        errorText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          height: 2,
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      CupertinoIcons.refresh,
      size: 60,
    );
  }
}
