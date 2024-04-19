import '../../../config/index.dart';

class Doctorcard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Doctorcard({super.key, required this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 160,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Adjust radius here
          ),
          child: Row(
            children: [
              SizedBox(
                width: Config.screenWidth! * 0.33,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/doctor2.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Dr ramy',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Cardiologist',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Spacer(flex: 1),
                      Spacer(flex: 1),
                      Spacer(flex: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.star_border, color: Colors.yellow, size: 16),
                          Spacer(flex: 1),
                          Text('4.5'),
                          Spacer(flex: 1),
                          Text('Reviews'),
                          Spacer(flex: 1),
                          Text('(20)'),
                          Spacer(flex: 1),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          //redirect to doctor details page
          Navigator.of(context).pushNamed(route);
        }, //redirect to doctor details
      ),
    );
  }
}
