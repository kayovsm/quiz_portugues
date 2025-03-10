import 'package:flutter/material.dart';

class AlertAnimationCommon extends StatefulWidget {
  final String image;

  const AlertAnimationCommon({super.key, required this.image});

  @override
  State<AlertAnimationCommon> createState() => _AlertAnimationCommonState();
}

class _AlertAnimationCommonState extends State<AlertAnimationCommon> {
  late Future<void> _delayFuture;

  @override
  void initState() {
    super.initState();
    _delayFuture = Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _delayFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AlertDialog(
            content: Image.asset(
              'assets/gifs/${widget.image}',
              height: 100,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
