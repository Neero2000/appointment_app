import '../../../config/index.dart';

class DoctorsLoading extends StatelessWidget {
  const DoctorsLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 3,
      itemBuilder: (context, index) {
        return const _Item1();
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
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
        height: 16.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Row(
          children: [
            SizedBox(width: 10),
            _Item2(),
            SizedBox(width: 10),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Title(),
                  SizedBox(height: 4),
                  _Title(),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.white, size: 20),
                      SizedBox(width: 2),
                      _Title(),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

class _Item2 extends StatelessWidget {
  const _Item2();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 30.w,
        height: 14.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
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
