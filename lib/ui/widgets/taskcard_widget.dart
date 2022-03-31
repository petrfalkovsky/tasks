import 'package:flutter/material.dart';

class OneTaskWidget extends StatelessWidget {
  const OneTaskWidget({
    Key? key,
    required this.text,
    required this.isDone,
  }) : super(key: key);

  final String text;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Container(
              width: 24.0,
              height: 24.0,
              margin: const EdgeInsets.only(
                right: 10.0,
              ),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment(
                        0.8, 0.0), // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      Color.fromRGBO(252, 252, 252, 1),
                      Color.fromRGBO(248, 248, 248, 1)
                    ], // red to yellow
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                      color: const Color.fromRGBO(218, 218, 218, 1),
                      width: 2.0)),
              child: isDone
                  ? const Image(
                      color: Color.fromRGBO(87, 87, 103, 1),
                      image: AssetImage(
                        'assets/images/check_icon.png',
                      ),
                    )
                  : const Image(
                      color: Colors.transparent,
                      image: AssetImage(
                        'assets/images/check_icon.png',
                      ),
                    ),
            ),
            Flexible(
              child: isDone
                  ? Text(
                      text ?? "(Here's a task item)",
                      style: const TextStyle(
                        color: Color.fromRGBO(87, 87, 103, 1),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter Medium',
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  : Text(
                      text ?? "(Here's a task item)",
                      style: const TextStyle(
                        color: Color.fromRGBO(87, 87, 103, 1),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter Medium',
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}













// старый виджет, его можно 

/* class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;

  const TaskCardWidget({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: const TextStyle(
              color: Color(0xFF211551),
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Text(
              desc ?? "No Description Added",
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF86829D),
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
  final String text;
  final bool isDone;

  const TodoWidget({required this.text, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: const EdgeInsets.only(
              right: 12.0,
            ),
            decoration: BoxDecoration(
                color: isDone ? const Color(0xFF7349FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                border: isDone
                    ? null
                    : Border.all(color: const Color(0xFF86829D), width: 1.5)),
            child: const Image(
              image: AssetImage('assets/images/check_icon.png'),
            ),
          ),
          Flexible(
            child: Text(
              text ?? "(Unnamed Todo)",
              style: TextStyle(
                color:
                    isDone ? const Color(0xFF211551) : const Color(0xFF86829D),
                fontSize: 16.0,
                fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
 */