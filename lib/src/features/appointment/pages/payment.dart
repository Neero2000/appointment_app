import '../../../config/index.dart';

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow only digits
    return newValue.copyWith(
        text: newValue.text.replaceAll(RegExp(r'[^0-9]'), ''));
  }
}

class PaymentMethodScreen extends StatefulWidget {
  static const String routeName = '/PaymentMethodScreenState';
  const PaymentMethodScreen({super.key});
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _type = 1;
  double defaultPadding = 16.0;

  void _handleRadio(Object? e) => setState(() {
        _type = e as int;
      });
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("check in"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 1
                        ? Border.all(width: 1, color: const Color(0xFF1C2A3A))
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: Color(0xFF1C2A3A),
                              ),
                              Text('Dahabia card ',
                                  style: _type == 1
                                      ? const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)
                                      : const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF1C2A3A))),
                            ],
                          ),
                          Image.asset("assets/credit-card.png",
                              width: 50, height: 50, fit: BoxFit.cover),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: size.width,
                  height: 55,
                  child: TextFormField(
                    enabled:
                        _type == 1, // Enable only when Dahabia card is selected
                    keyboardType:
                        TextInputType.number, // Set keyboard type to number
                    inputFormatters: [
                      CustomInputFormatter()
                    ], // Use custom input formatter
                    decoration: InputDecoration(
                      hintText: "Visa Card",
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 2
                        ? Border.all(width: 1, color: Color(0xFF1C2A3A))
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: Color(0xFF1C2A3A),
                              ),
                              Text('main a main ',
                                  style: _type == 2
                                      ? const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)
                                      : const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF1C2A3A))),
                            ],
                          ),
                          Spacer(),
                          Image.asset("assets/pay.png",
                              width: 45, height: 45, fit: BoxFit.cover),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: size.width,
                  height: 55,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Name & Family Name",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: size.width,
                  height: 55,
                  child: TextFormField(
                    keyboardType: TextInputType
                        .phone, // Optional: set keyboard type to phone
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ], // Allow only digits
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                const SizedBox(
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub-Total',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '\$250.00Da',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Taxe',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '\$250.00Da',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Prix Total',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '\$350.00Da',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.redAccent),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                InkWell(
                  onTap: () {},
                  child: Button(
                      width: double.infinity,
                      title: "Terminé",
                      onPressed: () =>
                          Navigator.of(context).pushNamed(AppointmentBookedPage.routeName),
                      disable: false),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
