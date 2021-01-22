import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';

class LoadingWIdget extends StatefulWidget {
  const LoadingWIdget({
    Key key,
  }) : super(key: key);

  @override
  _LoadingWIdgetState createState() => _LoadingWIdgetState();
}

class _LoadingWIdgetState extends State<LoadingWIdget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.repeat(reverse: true);
    animation = Tween(begin: 0.2, end: 0.5).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  void _startAnimation() {
    controller.stop();
    controller.reset();
    controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: AppColors.kSecondaryColor,
          borderRadius: BorderRadius.circular(7)),
      child: Center(
        child: Stack(
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Transform.scale(
                  scale: animation.value,
                  child: SvgPicture.asset("images/new/zed.svg")),
            )
          ],
        ),
      ),
    );
  }
}