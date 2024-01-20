import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BouncingBallDemo(),
    );
  }
}

class BouncingBallDemo extends StatefulWidget {
  const BouncingBallDemo({super.key});

  @override
  State<BouncingBallDemo> createState() => _BouncingBallDemoState();
}

class _BouncingBallDemoState extends State<BouncingBallDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bouncingAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 500,
        ));
    _bouncingAnimation = Tween<double>(
        end: 0, begin: 1
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuad),)..addStatusListener((status) {
       if(status == AnimationStatus.completed) {
         _controller.reverse();
       } else if(status == AnimationStatus.dismissed) {
         _controller.forward();
       }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _bouncingAnimation,
          builder: (context , child) {
            return Transform.translate(
              offset: Offset(0, -100*_bouncingAnimation.value),
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },

        ),
      ),
    );
  }
}


