import 'package:flutter/material.dart';

class CustomAnimatedText extends StatefulWidget {
  const CustomAnimatedText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<CustomAnimatedText> createState() => _CustomAnimatedTextState();
}

class _CustomAnimatedTextState extends State<CustomAnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double paddingBottom = 0;
  double opacity = 1;

  @override
  void initState() {
    showText = widget.text;
    controller = AnimationController(duration: const Duration(milliseconds: 700), vsync: this);
    controller.addListener(() {
      // debugPrint(controller.value.toString());
      setState(() {
        opacity = 1 * controller.value;
        paddingBottom = (1 - controller.value) * 16;
      });
    });
    // debugPrint('initState called');
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // debugPrint('didChangeDependencies called');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedText oldWidget) {
    // debugPrint('didUpdateWidget called');
    reAnimate(oldWidget.text, widget.text);
    super.didUpdateWidget(oldWidget);
  }

  Future<void> vanish(String oldText) async {
    showText = oldText;
    await controller.animateTo(0);
  }

  Future<void> appear(String newText) async {
    showText = newText;
    await controller.animateTo(1);
  }

  Future<void> reAnimate(String oldText, String newText) async {
    await vanish(oldText);
    await appear(newText);
  }

  late String showText;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: EdgeInsets.only(top: paddingBottom),
          child: Text(showText, textScaleFactor: 1.5, textAlign: TextAlign.start),
        ),
      ),
    );
  }
}
