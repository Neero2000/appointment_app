import '../index.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.social});
  final String social;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), side: const BorderSide(width: 1, color: Colors.black)),
      onPressed: () {},
      child: SizedBox(
          width: 40.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                'assets/$social.png',
                width: 40,
                height: 40,
              ),
              Text(
                social.toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          )),
    );
  }
}
