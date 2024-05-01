import '../../../config/index.dart';

class PaymentArgs {
  final DoctorModel doctor;
  final DateTime date;
  final TimeSlotModel timeSlot;
  const PaymentArgs({
    required this.doctor,
    required this.date,
    required this.timeSlot,
  });
}

class PaymentPage extends StatefulWidget {
  static const String path = '/payment';
  const PaymentPage({super.key});
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isCashPayment = false;

  @override
  Widget build(BuildContext context) {
    final PaymentArgs args = ModalRoute.of(context)?.settings.arguments as PaymentArgs;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: _BottomNavBar(
        doctor: args.doctor,
        date: args.date,
        timeSlot: args.timeSlot,
        isCashPayment: _isCashPayment,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        children: [
          const SizedBox(height: 30),
          PaymentMethodItem(
            text: "Dahabia card",
            assetPath: "assets/images/credit_card_icon.png",
            isSelected: !_isCashPayment,
            onChanged: () {
              setState(() {
                _isCashPayment = false;
              });
            },
          ),
          _CardNumber(isCashPayment: _isCashPayment),
          const SizedBox(height: 26),
          PaymentMethodItem(
            text: "Cash",
            assetPath: "assets/images/cash_icon.png",
            isSelected: _isCashPayment,
            onChanged: () {
              setState(() {
                _isCashPayment = true;
              });
            },
          ),
          const SizedBox(height: 18),
          const TextField(
            decoration: InputDecoration(hintText: "Full Name"),
          ),
          const SizedBox(height: 18),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(hintText: "Phone Number"),
          ),
          const SizedBox(height: 140),
        ],
      ),
    );
  }
}

class _CardNumber extends StatelessWidget {
  final bool isCashPayment;
  const _CardNumber({required this.isCashPayment});
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
      firstCurve: Curves.ease,
      secondCurve: Curves.ease,
      sizeCurve: Curves.ease,
      crossFadeState: isCashPayment == false ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: const SizedBox(),
      secondChild: Column(
        children: [
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(hintText: "Card Number"),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final DoctorModel doctor;
  final DateTime date;
  final TimeSlotModel timeSlot;
  final bool isCashPayment;
  const _BottomNavBar({
    required this.doctor,
    required this.date,
    required this.timeSlot,
    required this.isCashPayment,
  });
  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        _PaymentItem(
          title: 'SubTotal:',
          value: '${doctor.price} DA',
        ),
        const SizedBox(height: 8),
        _PaymentItem(
          title: 'Tax (10%):',
          value: '${(doctor.price * 0.1).toInt()} DA',
        ),
        const Divider(
          color: AppTheme.primaryColor,
          indent: 18,
          endIndent: 18,
        ),
        _PaymentItem(
          title: 'Total',
          value: '${(doctor.price * 0.1).toInt() + doctor.price} DA',
          isTotal: true,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            SizedBox(width: 4.w),
            Expanded(
              child: CustomLoadingButton(
                width: double.infinity,
                text: 'Make Reservation',
                loadingFunction: () async {
                  FirebaseFirestoreUtils firebaseFirestoreUtils = FirebaseFirestoreUtils.instance;
                  FirebaseAuthUtils firebaseAuthUtils = FirebaseAuthUtils.instance;
                  await firebaseFirestoreUtils
                      .createAppointment(
                    doctor: doctor,
                    date: date,
                    timeSlot: timeSlot,
                    isCashPayment: isCashPayment,
                    userId: firebaseAuthUtils.uid,
                  )
                      .then(
                    (_) {
                      router.launchAppointmentBooked();
                    },
                  );
                },
              ),
            ),
            SizedBox(width: 4.w),
          ],
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}

class _PaymentItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;
  const _PaymentItem({
    required this.title,
    required this.value,
    this.isTotal = false,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 18),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        const Expanded(child: SizedBox()),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 22 : 18,
            fontWeight: FontWeight.w600,
            color: isTotal ? Colors.redAccent : Colors.black,
          ),
        ),
        const SizedBox(width: 18),
      ],
    );
  }
}
