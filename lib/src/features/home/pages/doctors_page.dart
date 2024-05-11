import '../../../config/index.dart';

class DoctorsArgs {
  final String speciality;
  const DoctorsArgs({required this.speciality});
}

class DoctorsPage extends StatelessWidget {
  static const String path = '/doctors';
  const DoctorsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final DoctorsArgs args = ModalRoute.of(context)?.settings.arguments as DoctorsArgs;
    return Scaffold(
      appBar: CustomAppBar(title: args.speciality),
      body: _Body(speciality: args.speciality),
    );
  }
}

class _Body extends StatefulWidget {
  final String speciality;
  const _Body({
    required this.speciality,
  });
  @override
  State<_Body> createState() => _BodyPageState();
}

class _BodyPageState extends State<_Body> {
  final FirebaseFirestoreUtils _firebaseFirestoreUtils = FirebaseFirestoreUtils.instance;

  final List<DoctorModel> _doctors = [];
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    _fetchBestDoctors();
    super.initState();
  }

  @override
  void dispose() {
    _isLoading = true;
    _isError = false;
    super.dispose();
  }

  Future _fetchBestDoctors() async {
    final List<DoctorModel> doctors = await _firebaseFirestoreUtils.getDoctorsBySpeciality(speciality: widget.speciality);
    if (mounted) {
      setState(() {
        _doctors.clear();
        _doctors.addAll(doctors);
        _isLoading = false;
      });
    }
  }

  void _refresh() {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    _fetchBestDoctors();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return ErrorRefreshItem(
        errorText: "Error loading doctors. Please try again later.",
        refresh: _refresh,
      );
    }
    if (_isLoading) {
      return const DoctorsLoading();
    }
    if (_doctors.isEmpty) {
      return DoctorsEmpty(
        refresh: _refresh,
      );
    }
    return ListView.separated(
      itemCount: _doctors.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
      itemBuilder: (context, index) {
        return DoctorCard(doctor: _doctors[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
    );
  }
}
