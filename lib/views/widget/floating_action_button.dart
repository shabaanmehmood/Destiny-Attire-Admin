import 'package:flutter/material.dart';
class AnimatedFloatingButton extends StatefulWidget {
  const AnimatedFloatingButton({Key? key}) : super(key: key);

  @override
  _AnimatedFloatingButtonState createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton> with SingleTickerProviderStateMixin{
  AnimationController? _animationController;
  Animation? animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = ColorTween(begin: Colors.red, end: Colors.amber)
        .animate(_animationController!);
    _animationController?.addListener(() {
      setState(() {});
    });
    _animationController?.repeat();
    _animationController?.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
