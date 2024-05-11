import '../../../config/index.dart';

class BookingArgs {
  final DoctorModel doctor;
  const BookingArgs({required this.doctor});
}

class BookingPage extends StatefulWidget {
  static const String path = '/booking';
  const BookingPage({super.key});
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime _date = DateTime.now();
  TimeSlotModel? _timeSlot;

  bool get _isWeekend => [DateTime.friday, DateTime.saturday].contains(_date.weekday);

  @override
  Widget build(BuildContext context) {
    final BookingArgs args = ModalRoute.of(context)?.settings.arguments as BookingArgs;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Appointment'),
      bottomNavigationBar: _BottomNavBar(
        doctor: args.doctor,
        date: _date,
        timeSlot: _timeSlot,
        isEnabled: _timeSlot != null && !_isWeekend,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _Calendar(
              date: _date,
              onDateSelected: (DateTime date) {
                setState(() {
                  _date = date;
                  _timeSlot = null;
                });
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          const SliverToBoxAdapter(child: _Title(text: 'Sélectionnez heure')),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          _TimeSelector(
            timeSlot: _timeSlot,
            isWeekend: _isWeekend,
            timeSlotOnChanged: (TimeSlotModel timeSlot) {
              setState(() {
                _timeSlot = timeSlot;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final DoctorModel doctor;
  final DateTime date;
  final TimeSlotModel? timeSlot;
  final bool isEnabled;
  const _BottomNavBar({
    required this.doctor,
    required this.date,
    required this.timeSlot,
    required this.isEnabled,
  });
  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SizedBox(width: 4.w),
            Expanded(
              child: CustomLoadingButton(
                width: double.infinity,
                text: 'Confirmer',
                isEnabled: isEnabled,
                loadingFunction: () async {
                  final FirebaseFirestoreUtils firebaseFirestoreUtils = FirebaseFirestoreUtils.instance;
                  List<AppointmentModel> appointments = await firebaseFirestoreUtils.getAppointmentByDoctorDateTime(
                    doctorId: doctor.userId,
                    date: date,
                    timeSlot: timeSlot!,
                  );
                  if (appointments.isNotEmpty) {
                    ToastUtils().showErrorToast(msg: 'This Date and Time Slot are not available!');
                    return;
                  }
                  router.launchPayment(
                    arguments: PaymentArgs(
                      doctor: doctor,
                      date: date,
                      timeSlot: timeSlot!,
                    ),
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

class _Calendar extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onDateSelected;
  const _Calendar({
    required this.date,
    required this.onDateSelected,
  });
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: date,
      selectedDayPredicate: (day) => isSameDay(date, day),
      currentDay: DateTime.now(),
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 90)),
      calendarFormat: CalendarFormat.month,
      rowHeight: 55,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.grey[400],
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: AppTheme.primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronIcon: FaIcon(FontAwesomeIcons.chevronLeft),
        rightChevronIcon: FaIcon(FontAwesomeIcons.chevronRight),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        onDateSelected(selectedDay);
      },
    );
  }
}

class _Title extends StatelessWidget {
  final String text;
  const _Title({required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class _TimeSelector extends StatelessWidget {
  final TimeSlotModel? timeSlot;
  final bool isWeekend;
  final Function(TimeSlotModel) timeSlotOnChanged;
  const _TimeSelector({
    required this.timeSlot,
    required this.isWeekend,
    required this.timeSlotOnChanged,
  });
  @override
  Widget build(BuildContext context) {
    if (isWeekend) {
      return SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 18),
            Flexible(
              child: Text(
                'Weekend is not available,please select another date',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(width: 18),
          ],
        ),
      );
    }
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 12,
          children: [
            ...DataUtils.instance.timeSlots.map(
              (_) => TimeSlotItem(
                timeSlot: _,
                isSelected: timeSlot == _,
                onPressed: () => timeSlotOnChanged(_),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
