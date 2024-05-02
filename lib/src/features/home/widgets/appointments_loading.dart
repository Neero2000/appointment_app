import '../../../config/index.dart';

class AppointmentsLoading extends StatelessWidget {
  const AppointmentsLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      itemCount: 3,
      itemBuilder: (context, index) {
        return const _Item1();
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}

class _Item1 extends StatelessWidget {
  const _Item1();
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(height: 18),
              _Item2(),
              SizedBox(height: 25),
              _Item3(),
              SizedBox(height: 25),
              _Item4(),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item2 extends StatelessWidget {
  const _Item2();
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
        ),
        SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(),
            SizedBox(height: 10),
            _Title(),
          ],
        ),
      ],
    );
  }
}

class _Item3 extends StatelessWidget {
  const _Item3();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18),
      height: 55,
    );
  }
}

class _Item4 extends StatelessWidget {
  const _Item4();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            height: 45,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            color: Colors.white,
            height: 45,
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
