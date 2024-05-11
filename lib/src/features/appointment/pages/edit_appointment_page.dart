import '../../../config/index.dart';
import 'package:collection/collection.dart';

class EditAppointmentArgs {
  final AppointmentModel appointment;
  final VoidCallback refresh;
  const EditAppointmentArgs({
    required this.appointment,
    required this.refresh,
  });
}

class EditAppointmentPage extends StatelessWidget {
  static const String path = '/edit_appointment';
  const EditAppointmentPage({super.key});
  @override
  Widget build(BuildContext context) {
    final EditAppointmentArgs args = ModalRoute.of(context)?.settings.arguments as EditAppointmentArgs;
    return _Page(
      appointment: args.appointment,
      refresh: args.refresh,
    );
  }
}

class _Page extends StatefulWidget {
  final AppointmentModel appointment;
  final VoidCallback refresh;
  const _Page({
    required this.appointment,
    required this.refresh,
  });
  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  DateTime _date = DateTime.now();
  TimeSlotModel? _timeSlot;

  bool get _isWeekend => [DateTime.friday, DateTime.saturday].contains(_date.weekday);

  @override
  void initState() {
    _date = DateTime.parse(widget.appointment.date);
    _timeSlot = DataUtils.instance.timeSlots.firstWhereOrNull((_) => _.time == widget.appointment.time);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Appointment'),
      bottomNavigationBar: _BottomNavBar(
        appointment: widget.appointment,
        date: _date,
        timeSlot: _timeSlot,
        isEnabled: _timeSlot != null && !_isWeekend,
        refresh: widget.refresh,
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
  final AppointmentModel appointment;
  final DateTime date;
  final TimeSlotModel? timeSlot;
  final bool isEnabled;
  final VoidCallback refresh;
  const _BottomNavBar({
    required this.appointment,
    required this.date,
    required this.timeSlot,
    required this.isEnabled,
    required this.refresh,
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
                  FirebaseFirestoreUtils firebaseFirestoreUtils = FirebaseFirestoreUtils.instance;
                  await firebaseFirestoreUtils
                      .editAppointment(
                    appointment: appointment,
                    date: date,
                    timeSlot: timeSlot!,
                  )
                      .then(
                    (_) {
                      router.launchAppointmentSuccess(
                        arguments: const AppointmentSuccessArgs(
                          successText: 'Congratulations!\nYour appointment is eddited successfully',
                        ),
                      );
                      refresh();
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
