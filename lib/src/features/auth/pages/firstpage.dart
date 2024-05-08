import '../../../config/index.dart';
class FirstPage extends StatelessWidget {
  static const path = '/first';
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: ''),
      body: _Init(),
    );
  }
}

class _Init extends StatelessWidget {
  const _Init();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30.0),
          const Text(
            "Login",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: 250,
            height: 250,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle Doctor button tap
                },
                child: const Text('Doctor'),
                style: ElevatedButton.styleFrom(),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Patient button tap
                },
                child: const Text('Patient'),
                style: ElevatedButton.styleFrom(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
